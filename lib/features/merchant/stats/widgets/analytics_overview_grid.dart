import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

class AnalyticsOverviewGrid extends StatelessWidget {
  const AnalyticsOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        Gap(16.h),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context: context,
                icon: Iconsax.eye,
                iconColor: AppColors.blueAccentColor,
                title: AppStrings.totalViews.tr,
                value: '2,450',
              ),
            ),
            Gap(16.w),
            Expanded(
              child: _buildStatCard(
                context: context,
                icon: Iconsax.send_2,
                iconColor: AppColors.purpleAccentColor,
                title: AppStrings.clicks.tr,
                value: '03',
              ),
            ),
          ],
        ),
        Gap(16.h),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context: context,
                icon: Iconsax.tag,
                iconColor: AppColors.emeraldGreenColor,
                title: 'Claims',
                value: '180',
              ),
            ),
            Gap(16.w),
            Expanded(
              child: _buildStatCard(
                context: context,
                icon: Iconsax.dollar_square,
                iconColor: AppColors.amberYellowColor,
                title: AppStrings.estRevenue.tr,
                value: '\$2,450',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.sp,
            ),
          ),
          Gap(12.h),
          Text(
            title,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(4.h),
          Text(
            value,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
