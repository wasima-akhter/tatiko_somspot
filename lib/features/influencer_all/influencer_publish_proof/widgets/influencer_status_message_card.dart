import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class StatusMessageCard extends StatelessWidget {
  final String status;
  final String title;
  final String message;
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;

  const StatusMessageCard({
    super.key,
    required this.status,
    required this.title,
    required this.message,
    this.backgroundColor = const Color(0xFFF2FFF5),
    this.borderColor = const Color(0xFFD8F1DD),
    this.icon = Icons.check,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.emeraldGreenColor),
            ),
            child: Icon(icon, size: 14.sp, color: AppColors.emeraldGreenColor),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: context.bodySmall.copyWith(
                    color: AppColors.emeraldGreenColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 2.h),

                Text(
                  title,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  message,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.grayTextSecondaryColor,
                    fontSize: 12.sp,
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
