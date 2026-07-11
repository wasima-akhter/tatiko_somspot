import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../utils/extension/base_extension.dart';

class VideoStatBadge extends StatelessWidget {
  const VideoStatBadge({super.key, required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),

      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(30.r),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 12.sp),

          Gap(3.w),

          Text(
            value,
            style: context.bodySmall.copyWith(
              color: Colors.white,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
