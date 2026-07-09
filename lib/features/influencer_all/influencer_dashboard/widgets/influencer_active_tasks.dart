import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class InfluencerActiveTasks extends StatelessWidget {
  const InfluencerActiveTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _taskCard(
          context,
          restaurant: "Mogadishu Pizza",
          title: "Buy 1 Get 1 Free Promo",
          subtitle: "1 TikTok Video",
          status: "REVIEWING",
          statusColor: Colors.orange,
        ),
        Gap(12.h),
        _taskCard(
          context,
          restaurant: "Lido Beach Cafe",
          title: "Sunset Coffee Promotion",
          subtitle: "2 Instagram Stories",
          status: "IN PROGRESS",
          statusColor: AppColors.blueAccentColor,
        ),
        Gap(12.h),
        _taskCard(
          context,
          restaurant: "Lido Beach Cafe",
          title: "Sunset Coffee Promotion",
          subtitle: "2 Instagram Stories",
          status: "IN PROGRESS",
          statusColor: AppColors.blueAccentColor,
        ),
      ],
    );
  }

  Widget _taskCard(
    BuildContext context, {
    required String restaurant,
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                restaurant,
                style: context.bodySmall.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Text(
                  status,
                  style: context.bodySmall.copyWith(
                    color: statusColor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Text(
            title,
            style: context.titleMedium.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),

          Row(
            children: [
              Icon(Iconsax.video, size: 12.w),
              Gap(5),
              Text(
                subtitle,
                style: context.bodySmall.copyWith(
                  color: AppColors.subtitleTextColor,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
