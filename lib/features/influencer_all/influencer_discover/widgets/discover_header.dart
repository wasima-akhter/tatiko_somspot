import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_spot/utils/color/app_colors.dart';

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 55.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "Discover Campaigns",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),

          SizedBox(height: 18.h),

          Container(
            height: 48.h,

            padding: EdgeInsets.symmetric(horizontal: 15.w),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(14.r),
            ),

            child: Row(
              children: [
                Icon(Icons.search, size: 20.sp, color: Colors.grey),

                SizedBox(width: 10.w),

                Expanded(
                  child: Text(
                    "Search for restaurants, groceries...",
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ),

                Icon(Icons.tune, size: 20.sp, color: AppColors.primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
