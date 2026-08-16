import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/color/app_colors.dart';
import '../../../../../utils/extension/base_extension.dart';

class RequirementsSection extends StatelessWidget {
  const RequirementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Requirements",
          style: context.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.darkTextColor,
          ),
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: .05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.purpleAccentColor.withValues(alpha: .15),
            ),
          ),
          child: Text(
            "Minimum 5k followers.\nMust be based in Mogadishu.",
            style: context.bodySmall.copyWith(
              color: AppColors.purpleAccentColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
