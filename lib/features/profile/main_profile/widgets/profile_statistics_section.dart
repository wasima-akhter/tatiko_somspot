import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings/app_strings.dart';
import '../../../../utils/common_controller/common_controller.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../../utils/extension/base_extension.dart';
import '../controller/profile_controller.dart';
import 'profile_stat_card.dart';

class ProfileStatModel {
  final String title;
  final String value;

  ProfileStatModel({required this.title, required this.value});
}

class ProfileStatisticsSection extends StatelessWidget {
  const ProfileStatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final commonController = CommonController.to;
    final controller = ProfileScreenController.to;

    return Obx(() {
      // Merchandiser doesn't use profile stats.
      if (commonController.isMerchandiser) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF6BB5FF),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.currentPlan.tr,
                    style: context.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: .9),
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    AppStrings.proMonthly.tr,
                    style: context.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A9DF7),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  minimumSize: Size(0, 36.h),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                ),
                child: Text(
                  AppStrings.upgrade.tr,
                  style: context.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      // Profile API loading
      if (controller.profileLoading.value == ApiStatus.loading) {
        return const ProfileStatisticsSkeleton();
      }

      final stats = controller.profileStats;

      return Row(
        children: List.generate(stats.length, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                end: index == stats.length - 1 ? 0 : 12.w,
              ),
              child: ProfileStatCard(
                label: stats[index].title,
                value: stats[index].value,
              ),
            ),
          );
        }),
      );
    });
  }
}

class ProfileStatisticsSkeleton extends StatelessWidget {
  const ProfileStatisticsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: index == 2 ? 0 : 12.w),
            child: AutoShimmerAnimate(
              isLoading: true,
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 45.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),

                    Gap(8.h),

                    Container(
                      width: 60.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
