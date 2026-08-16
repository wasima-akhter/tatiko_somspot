import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:som_spot/share/export/screen_export.dart';

import 'location_tile_layer.dart';

class AppLocationPicker extends StatelessWidget {
  final MapController mapController;
  final LatLng selectedLatLng;
  final bool isSearching;
  final ValueChanged<LatLng> onMapTap;

  const AppLocationPicker({
    super.key,
    required this.mapController,
    required this.selectedLatLng,
    required this.isSearching,
    required this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 220.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: .2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: .08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: selectedLatLng,
                initialZoom: 14,
                onTap: (_, point) => onMapTap(point),
              ),
              children: [
                const LocationTileLayer(),

                MarkerLayer(
                  markers: [
                    Marker(
                      point: selectedLatLng,
                      width: 50,
                      height: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withValues(
                                    alpha: .4,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Iconsax.location5,
                              color: AppColors.white,
                              size: 18,
                            ),
                          ),
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(
                                alpha: .3,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            if (isSearching)
              Container(
                color: Colors.black.withValues(alpha: .3),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(
                              AppColors.primaryColor,
                            ),
                          ),
                        ),
                        Gap(12.w),
                        Text(
                          "Searching location...",
                          style: context.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
