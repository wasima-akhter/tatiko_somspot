import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../../../utils/extension/base_extension.dart';

class DeliverableTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String followers;

  const DeliverableTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.blueAccentColor.withValues(alpha: 0.1),
            ),
            padding: EdgeInsets.all(8),
            child: Icon(icon, color: color),
          ),

          SizedBox(width: 12.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.bodyMedium.copyWith(
                  color: AppColors.blackMainTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 2.h),

              Text(
                followers,
                style: context.bodySmall.copyWith(
                  color: Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
