import 'package:geolocator/geolocator.dart';
import 'package:som_spot/share/export/screen_export.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find<LocationController>();

  // =========================
  // State
  // =========================

  final latitude = RxnDouble();
  final longitude = RxnDouble();

  final isLoading = false.obs;
  final hasLocation = false.obs;

  final permission = LocationPermission.denied.obs;
  final isLocationServiceEnabled = false.obs;

  // =========================
  // Convenience
  // =========================

  double? get lat => latitude.value;

  double? get lng => longitude.value;

  bool get hasValidLocation =>
      latitude.value != null && longitude.value != null;

  // =========================
  // GET CURRENT LOCATION
  // =========================

  Future<Position?> getCurrentLocation({
    bool showSettingsOnFailure = true,
  }) async {
    if (isLoading.value) {
      return hasValidLocation ? _currentPosition : null;
    }

    try {
      isLoading.value = true;

      // --------------------------------------------------
      // 1. Check location service
      // --------------------------------------------------

      isLocationServiceEnabled.value =
          await Geolocator.isLocationServiceEnabled();

      if (!isLocationServiceEnabled.value) {
        if (showSettingsOnFailure) {
          await _showLocationServiceDialog();
        }

        return null;
      }

      // --------------------------------------------------
      // 2. Check permission
      // --------------------------------------------------

      permission.value = await Geolocator.checkPermission();

      // --------------------------------------------------
      // 3. Request permission if needed
      // --------------------------------------------------

      if (permission.value == LocationPermission.denied) {
        permission.value = await Geolocator.requestPermission();
      }

      // --------------------------------------------------
      // 4. User denied permission
      // --------------------------------------------------

      if (permission.value == LocationPermission.denied) {
        if (showSettingsOnFailure) {
          await _showPermissionDeniedDialog();
        }

        return null;
      }

      // --------------------------------------------------
      // 5. Permanently denied
      // --------------------------------------------------

      if (permission.value == LocationPermission.deniedForever) {
        if (showSettingsOnFailure) {
          await _showPermissionDeniedForeverDialog();
        }

        return null;
      }

      // --------------------------------------------------
      // 6. Get current position
      // --------------------------------------------------

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;
      hasLocation.value = true;

      debugPrint(
        'User location: '
        '${position.latitude}, ${position.longitude}',
      );

      return position;
    } catch (e, stackTrace) {
      debugPrint('Get current location error: $e');
      debugPrintStack(stackTrace: stackTrace);

      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // RETRY
  // =========================

  Future<Position?> retryLocation() async {
    return getCurrentLocation(showSettingsOnFailure: true);
  }

  // =========================
  // CURRENT POSITION
  // =========================

  Position? get _currentPosition {
    if (!hasValidLocation) return null;

    return Position(
      longitude: longitude.value!,
      latitude: latitude.value!,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }

  // =========================
  // SETTINGS
  // =========================

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // =========================
  // PERMISSION DENIED
  // =========================

  Future<void> _showPermissionDeniedDialog() async {
    await Get.dialog(
      AlertDialog(
        title: Text(AppStrings.locationPermissionRequired.tr),
        content: Text(AppStrings.locationPermissionMessage.tr),
        actions: [
          TextButton(onPressed: Get.back, child: Text(AppStrings.cancel.tr)),
          TextButton(
            onPressed: () async {
              Get.back();
              await getCurrentLocation();
            },
            child: Text(AppStrings.tryAgain.tr),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // =========================
  // PERMISSION DENIED FOREVER
  // =========================

  Future<void> _showPermissionDeniedForeverDialog() async {
    await Get.dialog(
      AlertDialog(
        title: Text(AppStrings.enableLocationPermission.tr),
        content: Text(AppStrings.locationPermissionDisabledMessage.tr),
        actions: [
          TextButton(onPressed: Get.back, child: Text(AppStrings.cancel.tr)),
          TextButton(
            onPressed: () async {
              Get.back();
              await Geolocator.openAppSettings();
            },
            child: Text(AppStrings.openSettings.tr),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  // =========================
  // LOCATION SERVICE DISABLED
  // =========================

  Future<void> _showLocationServiceDialog() async {
    await Get.dialog(
      AlertDialog(
        title: Text(AppStrings.locationIsDisabled.tr),
        content: Text(AppStrings.locationDisabledMessage.tr),
        actions: [
          TextButton(onPressed: Get.back, child: Text(AppStrings.cancel.tr)),
          TextButton(
            onPressed: () async {
              Get.back();

              await Geolocator.openLocationSettings();

              await Future.delayed(const Duration(milliseconds: 500));

              await getCurrentLocation();
            },
            child: Text(AppStrings.enableLocation.tr),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
