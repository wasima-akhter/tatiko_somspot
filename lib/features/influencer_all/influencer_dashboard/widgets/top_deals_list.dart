import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class TopDealsList extends StatelessWidget {
  const TopDealsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopDealItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Hilib Macaan • 184 claims',
          percentage: '18%',
          percentageColor: AppColors.emeraldGreenColor,
        ),
        Gap(12.h),
        _buildTopDealItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Hayat Supermarket • 142 claims',
          percentage: '12%',
          percentageColor: AppColors.emeraldGreenColor,
        ),
        Gap(12.h),
        _buildTopDealItem(
          context: context,
          title: '20% Off Family Platter',
          subtitle: 'Hilib Macaan • 96 claims',
          percentage: '4%',
          percentageColor: AppColors.orangeColor,
        ),
      ],
    );
  }

  Widget _buildTopDealItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String percentage,
    required Color percentageColor,
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
          Text(
            percentage,
            style: context.bodySmall.copyWith(
              fontWeight: FontWeight.bold,
              color: percentageColor,
            ),
          ),
        ],
      ),
    );
  }
}
