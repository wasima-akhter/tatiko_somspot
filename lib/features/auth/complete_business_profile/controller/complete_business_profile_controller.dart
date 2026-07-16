import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../core/router/route_path.dart';
import '../../../../core/router/routes.dart';
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

  // ── Step 1: Location ──
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final mapController = MapController();
  // Default: Aqua Tower, Mohakhali, Dhaka
  final selectedLatLng = const LatLng(23.78081, 90.40749).obs;

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

  // ── Map ──
  final isMapSearching = false.obs;

  // ── Map ──
  void updateMapPosition(LatLng latLng) {
    selectedLatLng.value = latLng;
    mapController.move(latLng, mapController.camera.zoom);
    reverseGeocode(latLng); // ⬅ NEW: sync address/city on direct map tap
  }

  Future<void> reverseGeocode(LatLng latLng) async {
    try {
      isMapSearching.value = true;

      debugPrint(
        '[Location][ReverseGeocode][Request] lat=${latLng.latitude}, lon=${latLng.longitude}',
      );

      final dio = Dio();
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'lat': latLng.latitude,
          'lon': latLng.longitude,
          'format': 'json',
          'addressdetails': 1,
        },
        options: Options(headers: {'User-Agent': 'som_spot/1.0'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        final displayName = (data['display_name'] ?? '').toString();
        final address = data['address'] as Map<String, dynamic>?;

        // prevent the address text-change listener from re-triggering suggestion search
        _isSelectingSuggestion = true;
        addressController.text = displayName;

        String city = '';
        if (address != null) {
          city =
              (address['city'] ??
                      address['town'] ??
                      address['village'] ??
                      address['suburb'] ??
                      address['state'] ??
                      '')
                  .toString();
          cityController.text = city;
        }

        debugPrint(
          '[Location][ReverseGeocode][Result] '
          'lat=${latLng.latitude}, '
          'lon=${latLng.longitude}, '
          'address="${displayName.isEmpty ? "N/A" : displayName}", '
          'city="${city.isEmpty ? "N/A" : city}"',
        );

        Future.delayed(const Duration(milliseconds: 100), () {
          _isSelectingSuggestion = false;
        });
      } else {
        debugPrint(
          '[Location][ReverseGeocode][Error] status=${response.statusCode}',
        );
        AppToast.error(message: AppStrings.errorSearchingLocation.tr);
      }
    } catch (e) {
      debugPrint('[Location][ReverseGeocode][Exception] error=$e');
      AppToast.error(message: AppStrings.errorSearchingLocation.tr);
    } finally {
      isMapSearching.value = false;
    }
  }

  Future<void> searchLocationFromAddress() async {
    final street = addressController.text.trim();
    final city = cityController.text.trim();

    if (street.isEmpty && city.isEmpty) {
      AppToast.warning(message: AppStrings.pleaseEnterAddressToSearch.tr);
      return;
    }

    final queryParts = <String>[];
    if (street.isNotEmpty) queryParts.add(street);
    if (city.isNotEmpty) queryParts.add(city);
    final query = queryParts.join(', ');

    try {
      isMapSearching.value = true;
      final dio = Dio();
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {'q': query, 'format': 'json', 'limit': 1},
        options: Options(headers: {'User-Agent': 'som_spot/1.0'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is List && data.isNotEmpty) {
          final firstResult = data[0];
          final lat = double.tryParse(firstResult['lat'].toString());
          final lon = double.tryParse(firstResult['lon'].toString());
          if (lat != null && lon != null) {
            final latLng = LatLng(lat, lon);
            updateMapPosition(latLng);
            AppToast.success(message: AppStrings.locationUpdatedOnMap.tr);

            //
            debugPrint(
              '[Location][AddressSearch][Result] '
              'lat=$lat, lon=$lon, '
              'query="$query"',
            );
          } else {
            AppToast.error(message: AppStrings.noLocationMatchesFound.tr);
          }
        } else {
          AppToast.error(message: AppStrings.noLocationMatchesFound.tr);
        }
      } else {
        AppToast.error(message: AppStrings.errorSearchingLocation.tr);
      }
    } catch (e) {
      AppToast.error(message: AppStrings.errorSearchingLocation.tr);
    } finally {
      isMapSearching.value = false;
    }
  }

  // ── Search Suggestions ──
  Timer? _debounce;
  final suggestions = <Map<String, dynamic>>[].obs;
  final isSearchingSuggestions = false.obs;
  bool _isSelectingSuggestion = false;

  void onAddressChanged(String query) {
    if (_isSelectingSuggestion) return;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (query.trim().length > 2) {
        fetchSuggestions(query);
      } else {
        suggestions.clear();
      }
    });
  }

  Future<void> fetchSuggestions(String query) async {
    try {
      isSearchingSuggestions.value = true;
      final dio = Dio();
      final response = await dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'format': 'json',
          'limit': 5,
          'addressdetails': 1,
        },
        options: Options(headers: {'User-Agent': 'som_spot/1.0'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is List) {
          suggestions.value = List<Map<String, dynamic>>.from(data);
        }
      }
    } catch (e) {
      // Fail silently to not disrupt typing
    } finally {
      isSearchingSuggestions.value = false;
    }
  }

  void selectSuggestion(Map<String, dynamic> suggestion) {
    _isSelectingSuggestion = true;

    final displayName = suggestion['display_name'] ?? '';
    final address = suggestion['address'] as Map<String, dynamic>?;

    addressController.text = displayName;

    if (address != null) {
      final city =
          address['city'] ??
          address['town'] ??
          address['village'] ??
          address['suburb'] ??
          address['state'] ??
          '';
      cityController.text = city.toString();
    }

    suggestions.clear();

    var lat = double.tryParse(suggestion['lat'].toString());
    var lon = double.tryParse(suggestion['lon'].toString());
    if (lat != null && lon != null) {
      updateMapPosition(LatLng(lat, lon));

      //
      debugPrint(
        '[Location][SuggestionSelected] '
        'lat=${lat ?? "N/A"}, lon=${lon ?? "N/A"}, '
        'address="${addressController.text.isEmpty ? "N/A" : addressController.text}", '
        'city="${cityController.text.isEmpty ? "N/A" : cityController.text}"',
      );
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      _isSelectingSuggestion = false;
    });
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

      final request = CompleteBusinessProfileRequest(
        name: businessNameController.text.trim(),

        category: selectedCategoryId.value,

        description: shortDescriptionController.text.trim(),

        phone: phoneController.text.trim(),

        address: addressController.text.trim(),

        lng: selectedLatLng.value.longitude,

        lat: selectedLatLng.value.latitude,

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
    _debounce?.cancel();
    pageController.dispose();
    mapController.dispose();
    businessNameController.dispose();
    shortDescriptionController.dispose();
    addressController.dispose();
    cityController.dispose();
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

    return true;
  }

  bool validateLocation() {
    if (addressController.text.trim().isEmpty) {
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
