import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../features/other/controller/other_controller.dart';
import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class RatingBottomSheet extends StatelessWidget {
  const RatingBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = OtherController.to;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 30.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Drag Handle
            Container(
              width: 45.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),

            Gap(20.h),

            /// Title & Close
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Text(
                        "Rate SomSpot",
                        style: context.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackMainTextColor,
                        ),
                      ),

                      Gap(4.h),

                      /// Subtitle
                      Text(
                        "Enjoying the app? Let us know!",
                        style: context.bodySmall.copyWith(
                          color: AppColors.grayTextSecondaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: AppColors.grayTextSecondaryColor,
                    size: 22.sp,
                  ),
                ),
              ],
            ),

            Gap(22.h),

            /// Rating Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 18.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Column(
                children: [
                  Text(
                    "Tap to rate",
                    style: context.bodyMedium.copyWith(
                      color: AppColors.grayTextSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Gap(18.h),

                  RatingBar.builder(
                    initialRating: controller.rating,
                    minRating: 1,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 38.sp,
                    unratedColor: Colors.grey.shade300,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemBuilder: (_, _) => const Icon(
                      Icons.star_rounded,
                      color: Color(0xffFFC529),
                    ),
                    onRatingUpdate: controller.updateRating,
                  ),

                  Gap(16.h),

                  Text(
                    controller.ratingText,
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackMainTextColor,
                    ),
                  ),
                ],
              ),
            ),

            Gap(28.h),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.send, size: 20.sp),
                label: Text(
                  "Submit Rating",
                  style: context.bodyMedium.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4DA3FF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
