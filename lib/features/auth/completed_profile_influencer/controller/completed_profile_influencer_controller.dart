import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/router/route_path.dart';
import '../../../../core/router/routes.dart';
import '../../../../helper/toast/toast_helper.dart';

class CompletedProfileInfluencerController extends GetxController {
  final RxnString selectedInfluencerType = RxnString();

  final influencerTypes = <String>[
    "Fashion",
    "Beauty",
    "Lifestyle",
    "Travel",
    "Food",
    "Fitness",
    "Technology",
    "Gaming",
    "Education",
    "Entertainment",
  ];

  // ----------------------------------
  // Location
  // ----------------------------------

  final mapController = MapController();

  final selectedLatLng = const LatLng(23.8103, 90.4125).obs;

  final isMapSearching = false.obs;
  final isSearchingSuggestions = false.obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();

  final suggestions = <Map<String, dynamic>>[].obs;

  Timer? _debounce;

  void onAddressChanged(String value) {
    _debounce?.cancel();

    if (value.trim().isEmpty) {
      suggestions.clear();
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () => searchSuggestions(value),
    );
  }

  Future<void> searchSuggestions(String query) async {
    if (query.trim().isEmpty) return;

    isSearchingSuggestions.value = true;

    try {
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/search'
          '?q=$query&format=jsonv2&addressdetails=1&limit=5',
        ),
        headers: {'User-Agent': 'SomSpot'},
      );

      if (response.statusCode == 200) {
        suggestions.assignAll(
          List<Map<String, dynamic>>.from(jsonDecode(response.body)),
        );
      } else {
        AppToast.error(message: "Failed to search location");
      }
    } catch (_) {
      AppToast.error(message: "Failed to search location");
    } finally {
      isSearchingSuggestions.value = false;
    }
  }

  Future<void> selectSuggestion(Map<String, dynamic> item) async {
    suggestions.clear();

    final lat = double.parse(item["lat"]);
    final lon = double.parse(item["lon"]);

    final point = LatLng(lat, lon);

    addressController.text = item["display_name"] ?? "";

    cityController.text =
        item["address"]?["city"] ??
        item["address"]?["town"] ??
        item["address"]?["village"] ??
        "";

    updateMapPosition(point);
  }

  Future<void> updateMapPosition(LatLng point) async {
    isMapSearching.value = true;

    try {
      selectedLatLng.value = point;
      mapController.move(point, 16);

      final response = await http.get(
        Uri.parse(
          "https://nominatim.openstreetmap.org/reverse"
          "?lat=${point.latitude}"
          "&lon=${point.longitude}"
          "&format=jsonv2",
        ),
        headers: {"User-Agent": "SomSpot"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        addressController.text = data["display_name"] ?? "";

        final address = data["address"] ?? {};

        cityController.text =
            address["city"] ??
            address["town"] ??
            address["village"] ??
            address["suburb"] ??
            "";
      } else {
        AppToast.error(message: "Failed to get location details");
      }
    } catch (_) {
      AppToast.error(message: "Failed to get location details");
    } finally {
      isMapSearching.value = false;
    }
  }

  Future<void> searchLocationFromAddress() async {
    final address = addressController.text.trim();

    if (address.isEmpty) {
      AppToast.warning(message: "Please enter an address to search");
      return;
    }

    await searchSuggestions(address);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    addressController.dispose();
    cityController.dispose();
    super.onClose();
  }

  // Existing methods...

  final profileImagePath = Rx<String?>(null);
  final isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickProfileImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 90,
    );

    if (picked != null) {
      profileImagePath.value = picked.path;
    }
  }

  // validations:
  bool validateProfile() {
    if (profileImagePath.value == null) {
      AppToast.error(message: "Please upload your profile photo");
      return false;
    }

    if (selectedInfluencerType.value == null ||
        selectedInfluencerType.value!.isEmpty) {
      AppToast.error(message: "Please select an influencer type");
      return false;
    }

    if (addressController.text.trim().isEmpty) {
      AppToast.error(message: "Please select your location");
      return false;
    }

    return true;
  }

  Future<void> finishSetup() async {
    if (!validateProfile()) {
      return;
    }

    try {
      isLoading.value = true;

      // upload API here

      await Future.delayed(const Duration(seconds: 1));

      AppRouter.route.goNamed(RoutePath.navigationPages);
    } finally {
      isLoading.value = false;
    }
  }
}
