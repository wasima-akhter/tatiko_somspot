import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import 'influencer_progress_line.dart';

class ProgressStep extends StatelessWidget {
  final int number;
  final String title;

  final bool isCurrent;
  final bool isCompleted;

  final bool showLeftLine;
  final bool showRightLine;

  const ProgressStep({
    super.key,
    required this.number,
    required this.title,
    required this.isCurrent,
    required this.isCompleted,
    required this.showLeftLine,
    required this.showRightLine,
  });

  @override
  Widget build(BuildContext context) {
    final active = isCompleted || isCurrent;

    return Row(
      children: [
        if (showLeftLine)
          Expanded(
            child: ProgressLine(active: isCompleted || isCurrent, isLeft: true),
          ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            children: [
              _circle(active),
              const SizedBox(height: 8),
              Text(
                title,
                style: context.bodySmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: active
                      ? AppColors.emeraldGreenColor
                      : AppColors.grayTextSecondaryColor,
                ),
              ),
            ],
          ),
        ),

        //
        if (showRightLine)
          Expanded(child: ProgressLine(active: isCompleted, isLeft: false)),
      ],
    );
  }

  Widget _circle(bool active) {
    if (isCompleted) {
      return Container(
        height: 28,
        width: 28,
        decoration: const BoxDecoration(
          color: AppColors.emeraldGreenColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 16),
      );
    }

    return Container(
      height: 30.w,
      width: 30.w,
      decoration: BoxDecoration(
        color: active ? AppColors.emeraldGreenColor : Colors.white,
        shape: BoxShape.circle,
        // border: Border.all(
        //   color: active
        //       ? AppColors.primaryColor
        //       : AppColors.grayTextSecondaryColor.withOpacity(.3),
        // ),
      ),
      alignment: Alignment.center,
      child: active && number == 1
          ? Icon(Iconsax.tick_circle, size: 15.sp, color: Colors.white)
          : Text(
              number.toString(),
              style: TextStyle(
                color: active ? Colors.white : AppColors.grayTextSecondaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
