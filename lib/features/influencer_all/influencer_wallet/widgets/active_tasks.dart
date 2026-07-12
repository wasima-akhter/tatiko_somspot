import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../../utils/extension/base_extension.dart';

class ActiveTasks extends StatelessWidget {
  ActiveTasks({super.key});

  final List<Map<String, String>> tasks = [
    {
      "title": "Commission: Somali Tech Store",
      "date": "Oct 12, 2023",
      "amount": "+125.00",
    },

    {
      "title": "Commission: Hayat Supermarket",
      "date": "Oct 12, 2023",
      "amount": "+50.00",
    },

    {
      "title": "Commission: Liido Beach Cafe",
      "date": "Oct 12, 2023",
      "amount": "+135.00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Active Tasks",
              style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
            ),

            Text(
              "View all",
              style: context.bodySmall.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        Gap(12.h),

        ...tasks.map(
          (task) => Container(
            margin: EdgeInsets.only(bottom: 12.h),

            padding: EdgeInsets.all(12.w),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),

            child: Row(
              children: [
                Container(
                  height: 34.h,
                  width: 34.w,

                  decoration: BoxDecoration(
                    color: const Color(0xffE8FFF2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),

                  child: Icon(
                    Iconsax.trend_up,
                    color: Colors.green,
                    size: 18.sp,
                  ),
                ),

                Gap(12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        task["title"]!,
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),

                      Gap(3.h),

                      Text(
                        task["date"]!,
                        style: context.bodySmall.copyWith(
                          color: AppColors.grayTextSecondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(6),

                Text(
                  "\$${task["amount"]}",
                  style: context.titleMedium.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
