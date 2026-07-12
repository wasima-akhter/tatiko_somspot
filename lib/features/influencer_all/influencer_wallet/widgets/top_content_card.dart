import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../../utils/extension/base_extension.dart';

class TopContentCard extends StatelessWidget {
  final String image;
  final String title;
  final String views;
  final String likes;
  final String platform;

  const TopContentCard({
    super.key,
    required this.image,
    required this.title,
    required this.views,
    required this.likes,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              image,
              width: 56.w,
              height: 56.w,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTextColor,
                  ),
                ),

                SizedBox(height: 6.h),

                Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 15.sp,
                      color: AppColors.blueAccentColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      views,
                      style: context.bodySmall.copyWith(
                        color: AppColors.grayTextSecondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                      ),
                    ),

                    SizedBox(width: 14.w),

                    Icon(
                      Iconsax.heart,
                      size: 14.sp,
                      color: Colors.pink.shade600,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      likes,
                      style: context.bodySmall.copyWith(
                        color: AppColors.grayTextSecondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(width: 14.w),

                    Text(
                      platform,
                      style: context.bodySmall.copyWith(
                        color: AppColors.purpleAccentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
