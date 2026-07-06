import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

class RecentClaimsList extends StatelessWidget {
  const RecentClaimsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRecentClaimItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Claimed by Ahmed M.',
        ),
        Gap(12.h),
        _buildRecentClaimItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Claimed by Ahmed M.',
        ),
        Gap(12.h),
        _buildRecentClaimItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Claimed by Ahmed M.',
        ),
      ],
    );
  }

  Widget _buildRecentClaimItem({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: AppColors.softSlateBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.tag,
              color: AppColors.slateIconColor,
              size: 20.sp,
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
                ),
                Gap(2.h),
                Text(
                  subtitle,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          Gap(8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.emeraldGreenColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              AppStrings.justNow.tr,
              style: context.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.emeraldGreenColor,
                fontSize: 10.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
