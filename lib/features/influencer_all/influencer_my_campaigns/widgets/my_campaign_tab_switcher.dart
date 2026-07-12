import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class CampaignTabSwitcher extends StatelessWidget {
  final int activeCount;
  final int completedCount;
  final bool isActiveSelected;
  final ValueChanged<bool> onChanged;

  const CampaignTabSwitcher({
    super.key,
    required this.activeCount,
    required this.completedCount,
    required this.isActiveSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: const Color(0xffEAF3FD),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabItem(
              title: "Active",
              count: activeCount,
              selected: isActiveSelected,
              onTap: () => onChanged(true),
            ),
          ),
          Expanded(
            child: _TabItem(
              title: "Completed",
              count: completedCount,
              selected: !isActiveSelected,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.count,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: selected ? 2 : 0,
          backgroundColor: selected ? Colors.white : Colors.transparent,
          foregroundColor: selected
              ? AppColors.primaryColor
              : Colors.grey.shade700,
          shadowColor: Colors.black12,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: selected
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$title ",
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(4),
                  CircleAvatar(
                    radius: 8.r,
                    backgroundColor: Colors.grey.shade200,
                    child: Text(
                      "$count",
                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                "$title  $count",
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
