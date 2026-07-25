import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

class TopDealsAnalyticsList extends StatelessWidget {
  const TopDealsAnalyticsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Deals',
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextColor,
              ),
            ),
            Row(
              children: [
                Icon(
                  Iconsax.medal_star5,
                  color: AppColors.amberYellowColor,
                  size: 16.sp,
                ),
                Gap(4.w),
                Text(
                  AppStrings.rankedByClaims.tr,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(16.h),
        _buildItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Hilib Macaan • 184 claims',
          percentage: '18%',
          isWarning: false,
        ),
        _buildItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Hayat Supermarket • 142 claims',
          percentage: '12%',
          isWarning: false,
        ),
        _buildItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Hilib Macaan • 96 claims',
          percentage: '4%',
          isWarning: true,
        ),
      ],
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String percentage,
    required bool isWarning,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
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
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.softBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Iconsax.tag,
                color: AppColors.subtitleTextColor,
                size: 24.sp,
              ),
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(4.h),
                Text(
                  subtitle,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ),
          ),
          Gap(12.w),
          Text(
            percentage,
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: isWarning ? AppColors.warning : AppColors.emeraldGreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
