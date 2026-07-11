import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class SubmissionInfoCard extends StatelessWidget {
  const SubmissionInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Somali Tech Store",
            style: context.bodySmall.copyWith(
              color: AppColors.grayTextSecondaryColor,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "New iPhone Launch",
            style: context.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.softBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              children: [
                Icon(
                  Icons.videocam_outlined,
                  size: 15.sp,
                  color: AppColors.purpleAccentColor,
                ),

                const SizedBox(width: 8),

                Text(
                  "1 YouTube Short",
                  style: context.bodyMedium.copyWith(
                    color: AppColors.purpleAccentColor,
                    fontWeight: FontWeight.w500,
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
