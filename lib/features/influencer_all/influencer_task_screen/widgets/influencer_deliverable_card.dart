import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/utils.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class InfluencerDeliverableCard extends StatelessWidget {
  final String deliverable;
  final IconData icon;
  final Color iconColor;

  const InfluencerDeliverableCard({
    super.key,
    required this.deliverable,
    this.icon = Icons.videocam_outlined,
    this.iconColor = AppColors.purpleAccentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.softBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.deliverable.tr,
            style: context.titleSmall.copyWith(
              color: AppColors.blackMainTextColor,
            ),
          ),

          Gap(4.h),

          Row(
            children: [
              Icon(icon, size: 18.sp, color: iconColor),

              Gap(8.w),

              Expanded(
                child: Text(
                  deliverable,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.blueTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
