import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:som_spot/features/auth/complete_business_profile/controller/complete_business_profile_controller.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class LocationStep extends StatelessWidget {
  const LocationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CompleteBusinessProfileController.to;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(8.h),

          // ── Title ──
          Text(
            AppStrings.whereAreYouLocated.tr,
            style: context.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(8.h),

          // ── Subtitle ──
          Text(
            AppStrings.locationSubtitle.tr,
            style: context.bodyLarge.copyWith(
              color: AppColors.subtitleTextColor,
              height: 1.5,
            ),
          ),
          Gap(24.h),

          // ── OpenStreetMap ──
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: 220.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(() {
                final LatLng latLng = controller.selectedLatLng.value;
                final isSearching = controller.isMapSearching.value;
                return Stack(
                  children: [
                    FlutterMap(
                      mapController: controller.mapController,
                      options: MapOptions(
                        initialCenter: latLng,
                        initialZoom: 14.0,
                        onTap: (tapPosition, point) {
                          controller.updateMapPosition(point);
                        },
                      ),
                      children: [
                        // ── Tile Layer (OpenStreetMap) ──
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.somspot.app',
                        ),

                        // ── Marker ──
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: latLng,
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
                                          color: AppColors.primaryColor
                                              .withValues(alpha: 0.4),
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
                                  // Pin shadow dot
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(top: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withValues(
                                        alpha: 0.3,
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
                        color: Colors.black.withValues(alpha: 0.3),
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
                                  color: Colors.black.withValues(alpha: 0.1),
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
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                                Gap(12.w),
                                Text(
                                  AppStrings.searchingLocation.tr,
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
                );
              }),
            ),
          ),
          Gap(24.h),

          // ── Street Address ──
          CustomTextField(
            controller: controller.addressController,
            title: AppStrings.streetAddress.tr,
            hintText: AppStrings.enterStreetAddress.tr,
            textInputAction: TextInputAction.next,
            onChanged: (val) => controller.onAddressChanged(val),
            prefixIcon: Icon(
              Iconsax.location,
              size: 20.sp,
              color: AppColors.hintTextColor,
            ),
            suffixIcon: Obx(() {
              if (controller.isSearchingSuggestions.value) {
                return Padding(
                  padding: EdgeInsets.all(12.w),
                  child: SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              }
              return IconButton(
                onPressed: () => controller.searchLocationFromAddress(),
                icon: Icon(
                  Iconsax.search_normal,
                  size: 20.sp,
                  color: AppColors.primaryColor,
                ),
              );
            }),
            onFieldSubmitted: (_) => controller.searchLocationFromAddress(),
          ),

          // ── Search Suggestions List ──
          Obx(() {
            if (controller.suggestions.isEmpty) return const SizedBox.shrink();
            return Container(
              margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
              constraints: BoxConstraints(maxHeight: 200.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.backgroundsLinesColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: controller.suggestions.length,
                separatorBuilder: (context, index) => const Divider(
                  color: AppColors.backgroundsLinesColor,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final suggestion = controller.suggestions[index];
                  final displayName = suggestion['display_name'] ?? '';
                  return ListTile(
                    leading: const Icon(
                      Iconsax.location,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      displayName,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.darkTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => controller.selectSuggestion(suggestion),
                  );
                },
              ),
            );
          }),
          Gap(16.h),

          // ── City ──
          CustomTextField(
            controller: controller.cityController,
            title: AppStrings.city.tr,
            hintText: AppStrings.enterCity.tr,
            textInputAction: TextInputAction.search,
            prefixIcon: Icon(
              Iconsax.building,
              size: 20.sp,
              color: AppColors.hintTextColor,
            ),
            suffixIcon: IconButton(
              onPressed: () => controller.searchLocationFromAddress(),
              icon: Icon(
                Iconsax.search_normal,
                size: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
            onFieldSubmitted: (_) => controller.searchLocationFromAddress(),
          ),
          Gap(32.h),
        ],
      ),
    );
  }
}
