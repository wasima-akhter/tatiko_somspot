import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../helper/toast/toast_helper.dart';
import '../../../../share/controller/screen_export.dart';
import '../../../core/business/controller/business-controller.dart';
import '../../../core/business/response/business-response.dart';
import '../../../core/location/controller/business_location_controller.dart';
import '../service/manage_listing_service.dart';

class MerchantListingController extends GetxController {
  final ManageBusinessService _service;

  MerchantListingController(this._service);

  static MerchantListingController get to => Get.find();

  // =========================
  // Edit Profile
  // =========================

  final businessNameController = TextEditingController();
  final descriptionController = TextEditingController();

  // loading states
  final isLoading = false.obs;

  // gallery
  final selectedGalleryImages = <File>[].obs;

  final selectedCategoryId = "".obs;

  // =========================
  // Gallery
  // =========================

  // =========================
  // Images
  // =========================

  final logoImage = Rx<File?>(null);

  final coverImage = Rx<File?>(null);

  final galleryImages = <File>[].obs;

  // =========================
  // Hours
  // =========================

  final businessHours = <String, Map<String, dynamic>>{}.obs;

  // =========================
  // Contact
  // =========================

  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();

  late final BusinessLocationController locationController;
  late final BusinessController businessController;

  @override
  void onInit() {
    super.onInit();

    if (!Get.isRegistered<BusinessLocationController>()) {
      Get.lazyPut(() => BusinessLocationController(), fenix: true);
    }

    businessController = BusinessController.to;
    locationController = BusinessLocationController.to;

    _initHours();

    debugPrint("MerchantListingController onInit");
    debugPrint(
      "Business items: ${businessController.myBusinessesPaginator.items.length}",
    );

    ever<List<BusinessModel>>(businessController.myBusinessesPaginator.items, (
      _,
    ) {
      debugPrint("Business list changed");
      loadBusiness();
    });

    // Important:
    // If data already exists when controller opens
    loadBusiness();
  }

  void _initHours() {
    const days = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"];

    businessHours.assignAll({
      for (final day in days)
        day: {"isOpen": false, "open": "09:00", "close": "17:00"},
    });
  }

  // =========================
  // image picker
  // =========================

  final _picker = ImagePicker();
  Future<void> pickLogoImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 90,
    );

    if (picked != null) {
      logoImage.value = File(picked.path);
    }
  }

  Future<void> pickCoverImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (picked != null) {
      coverImage.value = File(picked.path);
    }
  }

  // =========================
  // Gallery images
  // =========================
  final existingGalleryImages = <String>[].obs;
  final removedGalleryImages = <String>[].obs;

  // =========================
  // UPDATE PROFILE
  // =========================

  Future<void> updateBusinessProfile() async {
    if (businessNameController.text.trim().isEmpty) {
      AppToast.error(message: "Business name is required");
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      AppToast.error(message: "Description is required");
      return;
    }

    if (selectedCategoryId.value.isEmpty) {
      AppToast.error(message: "Please select a category");
      return;
    }

    await _patch(
      {
        "name": businessNameController.text.trim(),
        "description": descriptionController.text.trim(),
        "category": selectedCategoryId.value,
      },
      logo: logoImage.value,
      coverImage: coverImage.value,
    );
  }
  // =========================
  // UPDATE GALLERY
  // =========================

  Future<void> updateGallery() async {
    if (galleryImages.isEmpty) {
      AppToast.warning(message: "Please select gallery images");
      return;
    }

    await _patch({}, gallery: galleryImages);
  }
  // =========================
  // UPDATE HOURS
  // =========================

  Future<void> updateOperatingHours() async {
    final hasOpenDay = businessHours.values.any(
      (item) => item["isOpen"] == true,
    );

    if (!hasOpenDay) {
      AppToast.error(message: "Please select at least one open day");
      return;
    }

    final openingHours = <Map<String, dynamic>>[];

    businessHours.forEach((day, value) {
      final isOpen = value["isOpen"] == true;

      if (isOpen) {
        openingHours.add({
          "day": day,
          "open": value["open"] ?? "09:00",
          "close": value["close"] ?? "22:00",
        });
      }
    });

    await _patch({"openingHours": jsonEncode(openingHours)});
  }

  // =========================
  // UPDATE LOCATION
  // =========================

  Future<void> updateLocation() async {
    if (locationController.addressController.text.trim().isEmpty) {
      AppToast.error(message: "Address is required");
      return;
    }

    await _patch({
      "address": locationController.addressController.text.trim(),
      "lat": locationController.selectedLatLng.value.latitude,
      "lng": locationController.selectedLatLng.value.longitude,
    });
  }

  void prepareLocation({
    required String address,
    required String city,
    required double lat,
    required double lng,
  }) {
    locationController.reset(
      address: address,
      city: city,
      initialLatLng: LatLng(lat, lng),
    );
  }
  // =========================
  // UPDATE CONTACT
  // =========================

  Future<void> updateContact() async {
    final phone = phoneController.text.trim();
    final whatsapp = whatsappController.text.trim();

    if (phone.isEmpty) {
      AppToast.error(message: "Phone number is required");
      return;
    }

    if (phone.length < 8) {
      AppToast.error(message: "Enter a valid phone number");
      return;
    }

    final data = {"phone": phone};

    if (whatsapp.isNotEmpty) {
      data["whatsapp"] = whatsapp;
    }

    await _patch(data);
  }

  Future<void> _patch(
    Map<String, dynamic> data, {
    File? logo,
    File? coverImage,
    List<File>? gallery,
  }) async {
    try {
      isLoading.value = true;

      final response = await _service.updateBusiness(
        data: {...data, "businessId": selectedBusiness.value?.id ?? ''},
        logo: logo,
        coverImage: coverImage,
        gallery: gallery,
      );

      if (response.success) {
        AppToast.success(message: "Updated successfully");
        resetTemporarySelections();

        await businessController.myBusinessesPaginator.refresh();

        final businesses = businessController.myBusinessesPaginator.items;

        if (businesses.isNotEmpty) {
          selectedBusiness.value = businesses.first;

          await loadBusiness();
        }
      } else {
        AppToast.error(message: response.message);
      }
    } catch (e) {
      AppToast.error(message: "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  //
  void resetTemporarySelections() {
    // images picked from device
    logoImage.value = null;
    coverImage.value = null;
    galleryImages.clear();

    // gallery temporary state
    removedGalleryImages.clear();

    // remove keyboard focus
    FocusManager.instance.primaryFocus?.unfocus();
  }

  //
  final selectedBusiness = Rxn<BusinessModel>();

  String? get businessId => selectedBusiness.value?.id;

  //
  Future<void> loadBusiness() async {
    final businesses = businessController.myBusinessesPaginator.items;

    debugPrint("loadBusiness called. Count=${businesses.length}");

    if (businesses.isEmpty) return;

    final business = businesses.first;

    selectedBusiness.value = business;

    businessNameController.text = business.name;
    descriptionController.text = business.description;
    phoneController.text = business.phone;

    selectedCategoryId.value = business.categoryId;

    locationController.reset(
      address: business.address,
      city: business.city,
      initialLatLng: LatLng(business.latitude, business.longitude),
    );

    _loadOpeningHours(business.openingHours);

    existingGalleryImages.assignAll(business.gallery);

    resetTemporarySelections();

    debugPrint("Business refreshed: ${business.name}");
  }

  void _loadOpeningHours(List<BusinessHourModel> hours) {
    _initHours();

    for (final item in hours) {
      businessHours[item.day] = {
        "isOpen": !item.closed,
        "open": item.open,
        "close": item.close,
      };
    }

    businessHours.refresh();
  }

  @override
  void onClose() {
    businessNameController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    whatsappController.dispose();

    super.onClose();
  }
}
