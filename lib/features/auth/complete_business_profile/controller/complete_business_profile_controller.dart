import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../core/router/route_path.dart';
import '../../../../core/router/routes.dart';
import '../../../core/location/controller/business_location_controller.dart';
import '../service/complete_business_profile_request.dart';
import '../service/complete_business_profile_service.dart';

class CompleteBusinessProfileController extends GetxController {
  final CompleteBusinessProfileService _service;

  CompleteBusinessProfileController(this._service);

  static CompleteBusinessProfileController get to => Get.find();

  // ── Step Navigation ──
  final currentStep = 0.obs;
  final pageController = PageController();
  int totalSteps = 5;

  // ── Step 1: Business Info ──
  final businessNameController = TextEditingController();
  final shortDescriptionController = TextEditingController();

  // category
  final selectedCategoryId = "".obs;

  // ── Step 2: Business Hours ──
  final businessHours = <String, Map<String, dynamic>>{}.obs;

  // ── Step 3: Branding ──
  final coverImagePath = Rx<String?>(null);
  final logoImagePath = Rx<String?>(null);
  final _picker = ImagePicker();

  // ── Step 4: Contact ──
  final phoneController = TextEditingController();
  final whatsAppController = TextEditingController();
  final sameAsPhone = false.obs;

  // ── Loading ──
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    BusinessLocationController.to.reset(
      initialLatLng: const LatLng(23.78081, 90.40749),
    );
    _initBusinessHours();

    // Sync WhatsApp with phone when "same as phone" is toggled
    ever(sameAsPhone, (bool value) {
      if (value) {
        whatsAppController.text = phoneController.text;
      }
    });
  }

  void _initBusinessHours() {
    final days = [
      AppStrings.monday,
      AppStrings.tuesday,
      AppStrings.wednesday,
      AppStrings.thursday,
      AppStrings.friday,
      AppStrings.saturday,
      AppStrings.sunday,
    ];

    for (final day in days) {
      businessHours[day] = {
        'isOpen': true,
        'openTime': const TimeOfDay(hour: 9, minute: 0),
        'closeTime': const TimeOfDay(hour: 17, minute: 0),
      };
    }
    // Saturday & Sunday default to closed
    businessHours[AppStrings.saturday] = {
      'isOpen': false,
      'openTime': const TimeOfDay(hour: 9, minute: 0),
      'closeTime': const TimeOfDay(hour: 17, minute: 0),
    };
    businessHours[AppStrings.sunday] = {
      'isOpen': false,
      'openTime': const TimeOfDay(hour: 9, minute: 0),
      'closeTime': const TimeOfDay(hour: 17, minute: 0),
    };
  }

  // ── Navigation ──
  void nextStep() {
    if (!validateCurrentStep()) {
      return;
    }

    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;

      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      pageController.animateToPage(
        currentStep.value,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // ── Business Hours ──
  void toggleDayOpen(String day) {
    final current = businessHours[day]!;
    businessHours[day] = {...current, 'isOpen': !(current['isOpen'] as bool)};
    businessHours.refresh();
  }

  void updateOpenTime(String day, TimeOfDay time) {
    final current = businessHours[day]!;
    businessHours[day] = {...current, 'openTime': time};
    businessHours.refresh();
  }

  void updateCloseTime(String day, TimeOfDay time) {
    final current = businessHours[day]!;
    businessHours[day] = {...current, 'closeTime': time};
    businessHours.refresh();
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // ── Image Picking ──
  Future<void> pickCoverImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );
    if (picked != null) {
      coverImagePath.value = picked.path;
    }
  }

  Future<void> pickLogoImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 90,
    );
    if (picked != null) {
      logoImagePath.value = picked.path;
    }
  }

  // ── Phone sync ──
  void syncWhatsApp() {
    if (sameAsPhone.value) {
      whatsAppController.text = phoneController.text;
    }
  }

  // ── Finish Setup ──
  Future<void> finishSetup() async {
    if (!validateContact()) {
      return;
    }

    try {
      isLoading.value = true;

      final openingHours = <Map<String, dynamic>>[];

      businessHours.forEach((day, value) {
        final isOpen = value['isOpen'] as bool;

        if (isOpen) {
          openingHours.add({
            "day": _mapDayToApi(day),
            "open": _formatApiTime(value['openTime'] as TimeOfDay),
            "close": _formatApiTime(value['closeTime'] as TimeOfDay),
          });
        }
      });

      final location = BusinessLocationController.to;

      final request = CompleteBusinessProfileRequest(
        name: businessNameController.text.trim(),

        category: selectedCategoryId.value,

        description: shortDescriptionController.text.trim(),

        phone: phoneController.text.trim(),

        address: location.addressController.text.trim(),

        lng: location.selectedLatLng.value.longitude,

        lat: location.selectedLatLng.value.latitude,

        openingHours: openingHours,

        logo: File(logoImagePath.value!),

        coverImage: File(coverImagePath.value!),
      );
      final response = await _service.createBusiness(request);

      if (response.success) {
        AppRouter.route.goNamed(RoutePath.applicationSubmittedScreen);
      } else {
        AppToast.error(message: response.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  String _mapDayToApi(String day) {
    switch (day) {
      case AppStrings.monday:
        return "mon";

      case AppStrings.tuesday:
        return "tue";

      case AppStrings.wednesday:
        return "wed";

      case AppStrings.thursday:
        return "thu";

      case AppStrings.friday:
        return "fri";

      case AppStrings.saturday:
        return "sat";

      case AppStrings.sunday:
        return "sun";

      default:
        return "";
    }
  }

  String _formatApiTime(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  void onClose() {
    pageController.dispose();
    businessNameController.dispose();
    shortDescriptionController.dispose();
    phoneController.dispose();
    whatsAppController.dispose();
    super.onClose();
  }

  bool validateCurrentStep() {
    switch (currentStep.value) {
      case 0:
        return validateBusinessInfo();

      case 1:
        return validateLocation();

      case 2:
        return validateBusinessHours();

      case 3:
        return validateBranding();

      case 4:
        return validateContact();

      default:
        return true;
    }
  }

  bool validateBusinessInfo() {
    if (businessNameController.text.trim().isEmpty) {
      AppToast.error(message: "Please enter business name");
      return false;
    }

    if (shortDescriptionController.text.trim().isEmpty) {
      AppToast.error(message: "Please enter business description");
      return false;
    }

    if (selectedCategoryId.value.isEmpty) {
      AppToast.error(message: "Please select a business category");
      return false;
    }

    return true;
  }

  bool validateLocation() {
    final location = BusinessLocationController.to;

    if (location.addressController.text.trim().isEmpty) {
      AppToast.error(message: "Please select business location");

      return false;
    }

    return true;
  }

  bool validateBusinessHours() {
    final hasOpenDay = businessHours.values.any(
      (item) => item['isOpen'] == true,
    );

    if (!hasOpenDay) {
      AppToast.error(message: "Please select at least one open day");
      return false;
    }

    return true;
  }

  bool validateBranding() {
    if (coverImagePath.value == null) {
      AppToast.error(message: "Please upload cover image");
      return false;
    }

    if (logoImagePath.value == null) {
      AppToast.error(message: "Please upload logo image");
      return false;
    }

    return true;
  }

  bool validateContact() {
    if (phoneController.text.trim().isEmpty) {
      AppToast.error(message: "Please enter business phone number");
      return false;
    }

    // WhatsApp is optional, no validation needed

    return true;
  }
}

/*

{
  "name": "Hilib Macaan Restaurant", // Business name
  "category": "{{categoryId}}",
  "description": "Authentic Somali cuisine.", // Business description
  "phone": "+252612345678", // business phone
  "address": "Maka Al Mukarama Road, Mogadishu", // no manual type , only map address with long lat
  "lng": 45.3182,
  "lat": 2.0469,
  "openingHours": [
    {
      "day": 1,  // is this day name ?? 1 == ?? Saturday?
      "open": "09:00",  // please take this as timestamp with timezone. otherwise , timezone issue will come.
      "close": "22:00"
    }
  ]
}

*/
