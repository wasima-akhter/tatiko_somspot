import 'package:geolocator/geolocator.dart';
import 'package:som_spot/share/controller/screen_export.dart';

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

      // -------------------------
      // 1. Check GPS/location service
      // -------------------------

      isLocationServiceEnabled.value =
          await Geolocator.isLocationServiceEnabled();

      if (!isLocationServiceEnabled.value) {
        debugPrint('Location service is disabled.');

        if (showSettingsOnFailure) {
          await _showLocationServiceDialog();
        }

        return false;
      }

      // -------------------------
      // 2. Check permission
      // -------------------------

      permission.value = await Geolocator.checkPermission();

      // -------------------------
      // 3. Request permission
      // -------------------------

      if (permission.value == LocationPermission.denied) {
        permission.value = await Geolocator.requestPermission();
      }

      // -------------------------
      // 4. Still denied
      // -------------------------

      if (permission.value == LocationPermission.denied) {
        debugPrint('Location permission denied.');

        await _showPermissionDeniedDialog();

        return false;
      }

      // -------------------------
      // 5. Permanently denied
      // -------------------------

      if (permission.value == LocationPermission.deniedForever) {
        debugPrint('Location permission permanently denied.');

        await _showPermissionDeniedForeverDialog();

        return false;
      }

      // -------------------------
      // 6. Permission granted
      // -------------------------

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

      return true;
    } catch (e, stackTrace) {
      debugPrint('Get location error: $e');
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
        title: const Text('Location Permission Required'),
        content: const Text(
          'Som Spot needs your location to show nearby '
          'businesses and location-based content.',
        ),
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

              // Try permission again.
              await getCurrentLocation();
            },
            child: const Text('Try Again'),
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
        title: const Text('Enable Location Permission'),
        content: const Text(
          'Location permission has been disabled for this app. '
          'Please enable it from your device settings.',
        ),
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

              await Geolocator.openAppSettings();
            },
            child: const Text('Open Settings'),
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
        title: const Text('Location Is Disabled'),
        content: const Text(
          'Please enable location services on your device '
          'so Som Spot can determine your current location.',
        ),
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
            child: const Text('Enable Location'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
