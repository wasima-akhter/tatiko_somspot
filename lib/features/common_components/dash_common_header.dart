import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../core/router/route_path.dart';
import '../../helper/text_utils/string_helper.dart';
import '../../share/widgets/network_image/custom_network_image.dart';
import '../../utils/color/app_colors.dart';
import '../../utils/extension/base_extension.dart';

class DashboardHeaderModel {
  final RxString userName;
  final RxString userProfileImage;
  final RxString userAddress;

  DashboardHeaderModel({
    required this.userName,
    required this.userProfileImage,
    required this.userAddress,
  });
}

class DashboardCommonHeaderSec extends StatelessWidget {
  final DashboardHeaderModel data;

  const DashboardCommonHeaderSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(
                  () => Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                    child: ClipOval(
                      child: CustomNetworkImage(
                        imageUrl: data.userProfileImage.value,
                        boxShape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                Gap(12.w),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: context.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),

                    Obx(
                      () => Text(
                        data.userName.value.isEmpty
                            ? "User"
                            : data.userName.value.capitalizeWords(),
                        style: context.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            GestureDetector(
              onTap: () {
                Get.toNamed(RoutePath.alertScreen);
              },
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Badge(
                  backgroundColor: AppColors.redColor,
                  smallSize: 8,
                  child: Icon(
                    Iconsax.notification,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        Gap(16.h),

        Row(
          children: [
            Icon(
              Iconsax.location,
              color: Colors.white.withValues(alpha: 0.9),
              size: 16.sp,
            ),

            Gap(6.w),

            Expanded(
              child: Obx(
                () => Text(
                  data.userAddress.value.isEmpty
                      ? "Loading location..."
                      : data.userAddress.value,
                  style: context.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Shimmer
class DashboardCommonHeaderSecShimmer extends StatelessWidget {
  const DashboardCommonHeaderSecShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: AutoShimmerAnimate(
                    isLoading: true,
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                Gap(12.w),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: context.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),

                    Gap(6.h),

                    AutoShimmerAnimate(
                      isLoading: true,
                      child: Container(
                        width: 120.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Badge(
                backgroundColor: AppColors.redColor,
                smallSize: 8,
                child: Icon(
                  Iconsax.notification,
                  size: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        Gap(16.h),

        Row(
          children: [
            Icon(
              Iconsax.location,
              color: Colors.white.withValues(alpha: 0.9),
              size: 16.sp,
            ),
            Gap(6.w),
            Expanded(
              child: AutoShimmerAnimate(
                isLoading: true,
                child: Container(
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
