import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/home/controller/home_nearby_controller.dart';
import 'package:som_spot/features/home/widgets/home_shimmer_widgets.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class HomeNearbyWidget extends StatelessWidget {
  const HomeNearbyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeNearbyController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.nearbyYou.tr,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextColor,
              ),
            ),
            GestureDetector(
              onTap: () => AppRouter.route.pushNamed(RoutePath.nearbyYouScreen),
              child: Text(
                AppStrings.seeAll.tr,
                style: context.bodyMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        Gap(16.h),

        Obx(() {
          if (controller.isLoading.value) {
            return const NearbyMerchantShimmer();
          }

          if (controller.merchants.isEmpty) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "No nearby merchants found",
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.merchants.length,
            separatorBuilder: (context, index) => Gap(16.h),
            itemBuilder: (context, index) {
              final item = controller.merchants[index];
              return GestureDetector(
                onTap: () => AppRouter.route.pushNamed(
                  RoutePath.merchantDetailsScreen,
                  extra: item,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Part
                      SizedBox(
                        height: 150.h,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r),
                              ),
                              child: CustomNetworkImage(
                                imageUrl: item.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Star Rating Badge
                            Positioned(
                              top: 12.h,
                              right: 12.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color:
                                          AppColors.orangeSecondaryAccentColor,
                                      size: 14.sp,
                                    ),
                                    Gap(4.w),
                                    Text(
                                      item.rating,
                                      style: context.bodySmall.copyWith(
                                        color: AppColors.darkTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Information Part
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: context.titleLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkTextColor,
                              ),
                            ),
                            Gap(4.h),
                            Text(
                              item.category,
                              style: context.bodyMedium.copyWith(
                                color: AppColors.subtitleTextColor,
                              ),
                            ),
                            Gap(12.h),
                            Row(
                              children: [
                                // Distance
                                Icon(
                                  Icons.location_on,
                                  color: AppColors.primaryColor,
                                  size: 16.sp,
                                ),
                                Gap(4.w),
                                Text(
                                  item.distance,
                                  style: context.bodySmall.copyWith(
                                    color: AppColors.subtitleTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Gap(16.w),
                                // Open/Closed Status
                                Icon(
                                  Icons.access_time_filled,
                                  color: item.isOpen
                                      ? AppColors.success
                                      : AppColors.error,
                                  size: 16.sp,
                                ),
                                Gap(4.w),
                                Text(
                                  item.isOpen
                                      ? AppStrings.openNow.tr
                                      : AppStrings.closed.tr,
                                  style: context.bodySmall.copyWith(
                                    color: item.isOpen
                                        ? AppColors.success
                                        : AppColors.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
