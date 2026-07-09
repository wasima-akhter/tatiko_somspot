import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class InfluencerTaskCard extends StatelessWidget {
  final Map<String, dynamic> task;

  const InfluencerTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bool approved = task["approved"];

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.all(12.w),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task["merchant"],
                    style: context.bodySmall.copyWith(
                      color: AppColors.grayTextSecondaryColor,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),

                  decoration: BoxDecoration(
                    color: approved
                        ? Colors.green.withOpacity(.12)
                        : AppColors.primaryColor.withOpacity(.12),

                    borderRadius: BorderRadius.circular(8.r),
                  ),

                  child: Text(
                    approved ? "Approved" : "ACTIVE",
                    style: TextStyle(
                      color: approved ? Colors.green : AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            Text(
              task["title"],
              style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 14.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),

              decoration: BoxDecoration(
                color: AppColors.softBackgroundColor,
                borderRadius: BorderRadius.circular(12.r),
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    size: 18.sp,
                    color: AppColors.primaryColor,
                  ),

                  SizedBox(width: 8.w),

                  Text(task["deliverable"], style: context.bodySmall),
                ],
              ),
            ),

            if (approved) ...[
              SizedBox(height: 12.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Merchant note",
                      style: context.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Text(task["note"]),
                  ],
                ),
              ),
            ],

            SizedBox(height: 14.h),

            SizedBox(
              width: double.infinity,
              height: 42.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: approved
                      ? Colors.green
                      : AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(approved ? "Download Content" : "Submit Content"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
