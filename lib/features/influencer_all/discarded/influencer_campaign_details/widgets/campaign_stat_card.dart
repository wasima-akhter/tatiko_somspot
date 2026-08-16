import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../../../utils/extension/base_extension.dart';

class CampaignStatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final bool filledBackground;

  const CampaignStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.filledBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: filledBackground
              ? color.withValues(alpha: .06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: .15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18.sp, color: color),

            SizedBox(height: 8.h),

            Text(
              title,
              style: context.bodySmall.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: filledBackground
                    ? color
                    : Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),

            SizedBox(height: 3.h),

            Text(
              value,
              style: context.bodyMedium.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: filledBackground ? color : AppColors.blackMainTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
