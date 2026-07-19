import 'package:geocoding/geocoding.dart';

class LocationHelper {
  static const String fallbackAddress = 'Mogadishu, Somalia';

  static Future<String> getAddressFromCoordinates({
    required double latitude,
    required double longitude,
    String fallback = fallbackAddress,
  }) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) {
        return fallback;
      }

      final place = placemarks.first;

      final address = [
        place.street,
        place.locality,
        place.administrativeArea,
        place.country,
      ].where((e) => e != null && e.trim().isNotEmpty).join(', ');

      return address.isNotEmpty ? address : fallback;
    } catch (_) {
      return fallback;
    }
  }
}
