import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../features/customer/customer_business_details/shared/model/customer_buiness_details_model.dart';
import '../../../../features/profile/main_profile/controller/profile_controller.dart';
import '../../../../helper/launcher/launcher_helper.dart';
import '../../../../utils/config/app_config.dart';
import '../../../export/screen_export.dart';

/*
class DirectionsBottomSheet extends StatelessWidget {
  final BusinessDetailsModel business;

  const DirectionsBottomSheet({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDarkMode
        ? AppColors.white
        : AppColors.blackMainTextColor;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Gap(20.h),

            // Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.getDirections.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 22.sp,
                    color: primaryTextColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Text(
              AppStrings.chooseYourNavigationApp.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grayTextSecondaryColor,
              ),
            ),
            Gap(16.h),

            // Real Map Card
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = 180.h;
                return Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF0F172A,
                    ), // Slate 900 background for contrast
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Stack(
                    children: [
                      // Roads & Route
                      Positioned.fill(
                        child: SizedBox(
                          height: 180.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(23.76355, 90.4004),
                                initialZoom: 12,
                                interactionOptions: const InteractionOptions(
                                  flags: InteractiveFlag.none,
                                ),
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: AppConfig.mapTilerUrlTemplate,

                                  userAgentPackageName:
                                      AppConfig.userAgentPackageName,
                                ),

                                // Route
                                PolylineLayer(
                                  polylines: [
                                    Polyline(
                                      points: [
                                        const LatLng(23.7465, 90.3760),
                                        const LatLng(23.7550, 90.3850),
                                        const LatLng(23.7650, 90.4000),
                                        const LatLng(23.7806, 90.4248),
                                      ],
                                      color: Colors.blue,
                                      strokeWidth: 5,
                                    ),
                                  ],
                                ),

                                // Start + destination markers
                                MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: const LatLng(23.7465, 90.3760),
                                      width: 40,
                                      height: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.withValues(
                                                alpha: 0.35,
                                              ),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.navigation,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),

                                    Marker(
                                      point: const LatLng(23.7806, 90.4248),
                                      width: 45,
                                      height: 45,
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Bubble 1 (Fastest Route)
                      Positioned(
                        left: 12.w,
                        top: 12.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.navigation,
                                color: Colors.blue,
                                size: 14.sp,
                              ),
                              Gap(4.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "1.2 km • 8 min",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    AppStrings.fastestRoute.tr,
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Bubble 2 (Merchant Title)
                      Positioned(
                        right: 12.w,
                        top: 12.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Text(
                            business.name,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Gap(24.h),

            // Options (Google Maps & Apple Maps)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      LauncherHelper.launchDirectionsInGoogleMaps(
                        startLatitude: 23.7465,
                        startLongitude: 90.3760,
                        destinationLatitude: 23.7806,
                        destinationLongitude: 90.4248,
                      );
                    },
                    icon: const Icon(Icons.map_outlined),
                    label: Text(AppStrings.googleMaps.tr),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      LauncherHelper.launchDirectionsInAppleMaps(
                        startLatitude: 23.7465,
                        startLongitude: 90.3760,
                        destinationLatitude: 23.7806,
                        destinationLongitude: 90.4248,
                      );
                    },
                    icon: const Icon(Icons.apple),
                    label: Text(AppStrings.appleMaps.tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/

class DirectionsBottomSheet extends StatelessWidget {
  final BusinessDetailsModel business;

  const DirectionsBottomSheet({super.key, required this.business});

  static const double _maxRouteDistanceKm = 500;

  double _distanceInKm(LatLng from, LatLng to) {
    const distance = Distance();

    return distance.as(LengthUnit.Kilometer, from, to);
  }

  /// Converts GeoJSON coordinates:
  /// [longitude, latitude]
  ///
  /// into FlutterMap:
  /// LatLng(latitude, longitude)
  LatLng? _parseCoordinates(List<double>? coordinates) {
    if (coordinates == null || coordinates.length < 2) {
      return null;
    }

    final longitude = coordinates[0];
    final latitude = coordinates[1];

    // Validate coordinates before creating LatLng.
    if (!longitude.isFinite || !latitude.isFinite) {
      return null;
    }

    if (latitude < -90 || latitude > 90) {
      return null;
    }

    if (longitude < -180 || longitude > 180) {
      return null;
    }

    // Treat 0,0 as missing location.
    if (latitude == 0 && longitude == 0) {
      return null;
    }

    return LatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final primaryTextColor = isDarkMode
        ? AppColors.white
        : AppColors.blackMainTextColor;

    // ------------------------------------------------------------
    // FROM: User location
    //
    // Profile coordinates are GeoJSON:
    // [longitude, latitude]
    // ------------------------------------------------------------
    final userCoordinates =
        ProfileScreenController.to.userLocationCords.value.coordinates;
    final userAddress = ProfileScreenController.to.userLocationString.value;

    final from = _parseCoordinates(userCoordinates);

    // ------------------------------------------------------------
    // TO: Business location
    //
    // Business coordinates are also GeoJSON:
    // [longitude, latitude]
    // ------------------------------------------------------------
    final to = _parseCoordinates(business.location?.coordinates);

    // --------------------------------------------------------
    // Test Check
    // --------------------------------------------------------

    // Mock user location
    // CASE 1:
    // final from = _parseCoordinates([
    //   45.3182, // longitude
    //   2.0469, // latitude
    // ]);

    // // Mock business location
    // final to = _parseCoordinates([
    //   45.3400, // longitude
    //   2.0550, // latitude
    // ]);

    // CASE 2
    // final from = _parseCoordinates([45.3182, 2.0469]);

    // final to = null;

    // CASE 3
    // final from = null;

    // final to = _parseCoordinates([45.3400, 2.0550]);

    // CASE 4
    // final from = null;
    // final to = null;
    // --------------------------------------------------------
    // End Check
    // --------------------------------------------------------

    final hasFrom = from != null;
    final hasTo = to != null;
    final hasAnyLocation = hasFrom || hasTo;

    final distanceKm = hasFrom && hasTo ? _distanceInKm(from, to) : null;

    final isTooFar = distanceKm != null && distanceKm > _maxRouteDistanceKm;

    final hasRoute = hasFrom && hasTo && !isTooFar;

    // Center map around available location(s).
    final LatLng mapCenter;

    if (hasRoute) {
      mapCenter = LatLng(
        (from.latitude + to.latitude) / 2,
        (from.longitude + to.longitude) / 2,
      );
    } else if (from != null) {
      mapCenter = from;
    } else if (to != null) {
      mapCenter = to;
    } else {
      // Only used for MapOptions when there is no location.
      mapCenter = const LatLng(0, 0);
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------
            // Drag handle
            // ----------------------------------------------------
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),

            Gap(20.h),

            // ----------------------------------------------------
            // Title
            // ----------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.getDirections.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 22.sp,
                    color: primaryTextColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            Text(
              AppStrings.chooseYourNavigationApp.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grayTextSecondaryColor,
              ),
            ),

            Gap(16.h),

            // ============================================================
            // MAP
            // ============================================================
            Container(
              width: double.infinity,
              height: 180.h,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: !hasAnyLocation
                  ? _MapPlaceholder(isDarkMode: isDarkMode)
                  : isTooFar
                  ? _MapTooFarPlaceholder(distanceKm: distanceKm)
                  : Stack(
                      children: [
                        // ========================================================
                        // MAP
                        // ========================================================
                        Positioned.fill(
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: mapCenter,
                              initialZoom: hasRoute ? 13 : 14,
                              interactionOptions: const InteractionOptions(
                                flags: InteractiveFlag.none,
                              ),
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: AppConfig.mapTilerUrlTemplate,
                                userAgentPackageName:
                                    AppConfig.userAgentPackageName,
                              ),

                              // Route only when both are valid
                              if (hasRoute)
                                PolylineLayer(
                                  polylines: [
                                    Polyline(
                                      points: [from, to],
                                      color: Colors.blue,
                                      strokeWidth: 5,
                                    ),
                                  ],
                                ),

                              // Available markers
                              MarkerLayer(
                                markers: [
                                  if (from != null)
                                    Marker(
                                      point: from,
                                      width: 40,
                                      height: 40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.withValues(
                                                alpha: 0.35,
                                              ),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.navigation,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),

                                  if (to != null)
                                    Marker(
                                      point: to,
                                      width: 45,
                                      height: 45,
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // ========================================================
                        // DISTANCE BUBBLE
                        // ========================================================
                        if (hasRoute)
                          Positioned(
                            left: 12.w,
                            top: 12.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.12),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.navigation,
                                    color: Colors.blue,
                                    size: 14.sp,
                                  ),
                                  Gap(5.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        business.distanceLabel,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        AppStrings.fastestRoute.tr,
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // ========================================================
                        // BUSINESS NAME BUBBLE
                        // ========================================================
                        if (hasTo)
                          Positioned(
                            right: 12.w,
                            top: 12.h,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 150.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  business.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
            // ----------------------------------------------------
            // Distance / route info
            // ----------------------------------------------------
            if (hasAnyLocation) ...[
              Gap(24.h),

              if (hasFrom) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.my_location, color: Colors.blue, size: 18.sp),
                    Gap(6.w),
                    Expanded(
                      child: Text(
                        'From: ${hasFrom ? userAddress : ''}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              if (hasFrom && hasTo) Gap(8.h),

              if (hasTo) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 18.sp),
                    Gap(6.w),
                    Expanded(
                      child: Text(
                        'To: ${business.address}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
            Gap(24.h),

            // ----------------------------------------------------
            // Navigation buttons
            //
            // Only enabled when BOTH coordinates exist.
            // ----------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: !hasRoute
                        ? null
                        : () {
                            Navigator.of(context).pop();

                            LauncherHelper.launchDirectionsInGoogleMaps(
                              startLatitude: from.latitude,
                              startLongitude: from.longitude,
                              destinationLatitude: to.latitude,
                              destinationLongitude: to.longitude,
                            );
                          },
                    icon: const Icon(Icons.map_outlined),
                    label: Text(AppStrings.googleMaps.tr),
                  ),
                ),

                Gap(12.w),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: !hasRoute
                        ? null
                        : () {
                            Navigator.of(context).pop();

                            LauncherHelper.launchDirectionsInAppleMaps(
                              startLatitude: from.latitude,
                              startLongitude: from.longitude,
                              destinationLatitude: to.latitude,
                              destinationLongitude: to.longitude,
                            );
                          },
                    icon: const Icon(Icons.apple),
                    label: Text(AppStrings.appleMaps.tr),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// MAP PLACEHOLDER
// ================================================================

class _MapPlaceholder extends StatelessWidget {
  final bool isDarkMode;

  const _MapPlaceholder({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? Colors.white70 : Colors.grey.shade600;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withValues(alpha: .08)
                  : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.location_off_outlined,
              size: 26.sp,
              color: textColor,
            ),
          ),

          Gap(10.h),

          Text(
            'Location not available',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),

          Gap(4.h),

          Text(
            'Map location could not be found',
            style: TextStyle(
              fontSize: 11.sp,
              color: textColor.withValues(alpha: .7),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapTooFarPlaceholder extends StatelessWidget {
  final double distanceKm;

  const _MapTooFarPlaceholder({required this.distanceKm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: .1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.public_off_outlined,
                size: 26.sp,
                color: Colors.orange,
              ),
            ),

            Gap(10.h),

            Text(
              'Location is too far away',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),

            Gap(4.h),

            Text(
              '${distanceKm.toStringAsFixed(0)} km away',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
