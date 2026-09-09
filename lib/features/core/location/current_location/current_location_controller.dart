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
  // INIT
  // =========================

  @override
  void onInit() {
    super.onInit();

    // Try automatically when controller starts.
    getCurrentLocation();
  }

  // =========================
  // GET LOCATION
  // =========================

  Future<bool> getCurrentLocation({bool showSettingsOnFailure = true}) async {
    if (isLoading.value) return hasValidLocation;

    try {
      isLoading.value = true;

      // --------------------------------------------------
      // 1. Check if location service/GPS is enabled
      // --------------------------------------------------

      isLocationServiceEnabled.value =
          await Geolocator.isLocationServiceEnabled();

      if (!isLocationServiceEnabled.value) {
        print('Location service is disabled.');

        if (showSettingsOnFailure) {
          await _showLocationServiceDialog();
        }

        return false;
      }

      // --------------------------------------------------
      // 2. Check current permission
      // --------------------------------------------------

      permission.value = await Geolocator.checkPermission();

      // --------------------------------------------------
      // 3. Already have permission → don't request again
      // --------------------------------------------------

      if (permission.value == LocationPermission.always ||
          permission.value == LocationPermission.whileInUse) {
        print('Location permission already granted.');
      }
      // --------------------------------------------------
      // 4. Permission not granted → request it
      // --------------------------------------------------
      else if (permission.value == LocationPermission.denied) {
        print('Requesting location permission...');

        permission.value = await Geolocator.requestPermission();

        // User denied the request
        if (permission.value == LocationPermission.denied) {
          print('Location permission denied.');

          await _showPermissionDeniedDialog();

          return false;
        }
      }
      // --------------------------------------------------
      // 5. Permission permanently denied
      // --------------------------------------------------
      else if (permission.value == LocationPermission.deniedForever) {
        print('Location permission permanently denied.');

        if (showSettingsOnFailure) {
          await _showPermissionDeniedDialog();
        }

        return false;
      }

      // --------------------------------------------------
      // 6. Get current location
      // --------------------------------------------------

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      hasLocation.value = true;

      print(
        'User location: '
        '${position.latitude}, ${position.longitude}',
      );

      return true;
    } catch (e, stackTrace) {
      print('Get current location error: $e');
      debugPrintStack(stackTrace: stackTrace);

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // RETRY
  // =========================

  Future<bool> retryLocation() async {
    return getCurrentLocation(showSettingsOnFailure: true);
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
  // PERMISSION DIALOG
  // =========================

  Future<void> _showPermissionDeniedDialog() async {
    await Get.dialog(
      AlertDialog(
        title: Text(AppStrings.locationPermissionRequired.tr),
        content: Text(AppStrings.locationPermissionMessage.tr),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(AppStrings.cancel.tr),
          ),
          TextButton(
            onPressed: () async {
              Get.back();

              // Try permission again.
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
  // PERMANENTLY DENIED
  // =========================

  Future<void> _showPermissionDeniedForeverDialog() async {
    await Get.dialog(
      AlertDialog(
        title: Text(AppStrings.enableLocationPermission.tr),
        content: Text(AppStrings.locationPermissionDisabledMessage.tr),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(AppStrings.cancel.tr),
          ),
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
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();

              await Geolocator.openLocationSettings();

              // Give the settings screen a moment to close,
              // then try again.
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
