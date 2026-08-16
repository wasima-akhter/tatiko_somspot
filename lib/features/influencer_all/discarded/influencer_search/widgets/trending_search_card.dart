import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/color/app_colors.dart';
import '../../../../../utils/extension/base_extension.dart';

class TrendingSearchCard extends StatelessWidget {
  final String title;

  const TrendingSearchCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),

      padding: EdgeInsets.all(10.w),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12.r),
      ),

      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.h,

            decoration: BoxDecoration(
              color: const Color(0xffEAF4FF),

              borderRadius: BorderRadius.circular(8.r),
            ),

            child: Icon(
              Iconsax.trend_up,
              size: 16.sp,
              color: AppColors.blueAccentColor,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Text(
              title,

              style: context.titleSmall.copyWith(fontWeight: FontWeight.w600),
            ),
          ),

          Icon(Icons.chevron_right, color: Colors.grey, size: 22.sp),
        ],
      ),
    );
  }
}
