import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../helper/toast/toast_helper.dart';
import '../current_location/current_location_controller.dart';

class BusinessLocationController extends GetxController {
  static BusinessLocationController get to => Get.find();

  // =========================
  // Controllers
  // =========================

  final addressController = TextEditingController();

  final cityController = TextEditingController();

  // =========================
  // Map
  // =========================

  final mapController = MapController();

  final selectedLatLng = const LatLng(23.78081, 90.40749).obs;

  final isMapSearching = false.obs;

  final isGettingCurrentLocation = false.obs;

  // =========================
  // Suggestions
  // =========================

  final suggestions = <Map<String, dynamic>>[].obs;

  final isSearchingSuggestions = false.obs;

  Timer? _debounce;

  bool _isSelectingSuggestion = false;

  // =========================
  // Use Current Location
  // =========================

  Future<void> useCurrentLocation() async {
    isGettingCurrentLocation.value = true;
    final position = await LocationController.to.getCurrentLocation();

    if (position == null) {
      return;
    }

    final latLng = LatLng(position.latitude, position.longitude);

    //

    updateMapPosition(latLng);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        mapController.move(latLng, 16);
      } catch (e) {
        debugPrint('Could not move map: $e');
      }
    });

    isGettingCurrentLocation.value = false;

    AppToast.success(message: AppStrings.currentLocationSelected.tr);
  }
  // =========================
  // MAP TAP
  // =========================

  void updateMapPosition(LatLng latLng) {
    selectedLatLng.value = latLng;

    mapController.move(latLng, mapController.camera.zoom);

    reverseGeocode(latLng);
  }

  // =========================
  // REVERSE GEOCODE
  // =========================

  Future<void> reverseGeocode(LatLng latLng) async {
    try {
      isMapSearching.value = true;

      final dio = Dio();

      final response = await dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          "lat": latLng.latitude,

          "lon": latLng.longitude,

          "format": "json",

          "addressdetails": 1,
        },

        options: Options(headers: {"User-Agent": "som_spot/1.0"}),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        _isSelectingSuggestion = true;

        addressController.text = data["display_name"] ?? "";

        final address = data["address"] as Map<String, dynamic>?;

        cityController.text =
            (address?["city"] ??
                    address?["town"] ??
                    address?["village"] ??
                    address?["state"] ??
                    "")
                .toString();

        Future.delayed(const Duration(milliseconds: 100), () {
          _isSelectingSuggestion = false;
        });
      }
    } catch (e) {
      print("Reverse geocode error $e");
    } finally {
      isMapSearching.value = false;
    }
  }

  // =========================
  // ADDRESS SEARCH
  // =========================

  Future<void> searchLocationFromAddress() async {
    final street = addressController.text.trim();

    final city = cityController.text.trim();

    if (street.isEmpty && city.isEmpty) {
      AppToast.warning(message: AppStrings.pleaseEnterAddressToSearch.tr);

      return;
    }

    final query = [
      if (street.isNotEmpty) street,

      if (city.isNotEmpty) city,
    ].join(", ");

    try {
      isMapSearching.value = true;

      final dio = Dio();

      final response = await dio.get(
        'https://nominatim.openstreetmap.org/search',

        queryParameters: {"q": query, "format": "json", "limit": 1},

        options: Options(headers: {"User-Agent": "som_spot/1.0"}),
      );

      final data = response.data;

      if (data is List && data.isNotEmpty) {
        final result = data.first;

        final lat = double.tryParse(result["lat"]);

        final lon = double.tryParse(result["lon"]);

        if (lat != null && lon != null) {
          updateMapPosition(LatLng(lat, lon));

          AppToast.success(message: AppStrings.locationUpdatedOnMap.tr);
        }
      }
    } finally {
      isMapSearching.value = false;
    }
  }

  // =========================
  // Suggestions
  // =========================

  void onAddressChanged(String value) {
    if (_isSelectingSuggestion) return;

    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (value.trim().length > 2) {
        fetchSuggestions(value);
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
          "q": query,

          "format": "json",

          "limit": 5,

          "addressdetails": 1,
        },

        options: Options(headers: {"User-Agent": "som_spot/1.0"}),
      );

      if (response.data is List) {
        suggestions.value = List<Map<String, dynamic>>.from(response.data);
      }
    } finally {
      isSearchingSuggestions.value = false;
    }
  }

  void selectSuggestion(Map<String, dynamic> item) {
    _isSelectingSuggestion = true;

    addressController.text = item["display_name"] ?? "";

    final address = item["address"];

    if (address != null) {
      cityController.text =
          (address["city"] ??
                  address["town"] ??
                  address["village"] ??
                  address["state"] ??
                  "")
              .toString();
    }

    suggestions.clear();

    final lat = double.tryParse(item["lat"].toString());

    final lon = double.tryParse(item["lon"].toString());

    if (lat != null && lon != null) {
      updateMapPosition(LatLng(lat, lon));
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      _isSelectingSuggestion = false;
    });
  }

  //
  void setLocationFromProfile({
    required LatLng latLng,
    String? address,
    String? city,
  }) {
    selectedLatLng.value = latLng;

    if (address != null) {
      addressController.text = address;
    }

    if (city != null) {
      cityController.text = city;
    }

    // Move the map camera after the map has been rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        mapController.move(latLng, 15);
      } catch (e) {
        print('Could not move map: $e');
      }
    });
  }

  void reset({LatLng? initialLatLng, String? address, String? city}) {
    selectedLatLng.value = initialLatLng ?? const LatLng(23.78081, 90.40749);

    addressController.text = address ?? '';
    cityController.text = city ?? '';

    suggestions.clear();
  }

  @override
  void onClose() {
    _debounce?.cancel();

    mapController.dispose();

    addressController.dispose();

    cityController.dispose();

    super.onClose();
  }
}
