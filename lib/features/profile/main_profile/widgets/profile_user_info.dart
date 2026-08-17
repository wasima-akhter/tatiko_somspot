import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';

import '../../../../helper/text_utils/string_extension.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../utils/extension/base_extension.dart';
import '../controller/profile_controller.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileScreenController.to;

    return Obx(() {
      return ApiStatusBuilder(
        status: controller.profileLoading.value,
        errorMessage: controller.errorMessage.value,
        loadingWidget: const ProfileUserInfoSkeleton(),
        onRetry: controller.getProfile,
        builder: (context) => Row(
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.w),
              ),
              child: ClipOval(
                child: controller.userAvatar.value.isEmpty
                    ? Icon(Iconsax.user, color: Colors.white, size: 30.sp)
                    : CustomNetworkImage(
                        imageUrl: controller.userAvatar.value,
                        boxShape: BoxShape.circle,
                      ),
              ),
            ),

            Gap(12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.userName.value.capitalizeWords(),
                    style: context.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(2.h),

                  Text(
                    controller.userEmail.value,
                    style: context.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: .85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ProfileUserInfoSkeleton extends StatelessWidget {
  const ProfileUserInfoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoShimmerAnimate(
      isLoading: true,
      baseColor: Colors.white.withValues(alpha: .15),
      highlightColor: Colors.white.withValues(alpha: .3),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.w),
            ),
          ),

          Gap(12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 130.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),

                Gap(7.h),

                Container(
                  width: 190.w,
                  height: 13.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
