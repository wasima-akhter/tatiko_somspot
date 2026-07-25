import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class CampaignTabs extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChange;

  const CampaignTabs({
    super.key,
    required this.selected,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ["All", "Pending", "Approved"];

    return Row(
      children: List.generate(tabs.length, (index) {
        final active = selected == index;

        return GestureDetector(
          onTap: () => onChange(index),

          child: Container(
            margin: EdgeInsets.only(right: 10.w),

            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),

            decoration: BoxDecoration(
              color: active ? AppColors.primaryColor : AppColors.white,

              borderRadius: BorderRadius.circular(20.r),
            ),

            child: Text(
              tabs[index],

              style: context.bodySmall.copyWith(
                fontSize: 11.sp,

                fontWeight: active ? FontWeight.w600 : FontWeight.w500,

                color: active ? Colors.white : AppColors.subtitleTextColor,
              ),
            ),
          ),
        );
      }),
    );
  }
}
