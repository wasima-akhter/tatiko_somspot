import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_spot/utils/color/app_colors.dart';

class ProfileMenuCard extends StatelessWidget {
  final List<Widget> children;

  const ProfileMenuCard({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        children: List.generate(children.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Divider(
              color: AppColors.backgroundsLinesColor.withValues(alpha: 0.5),
              height: 1.h,
              thickness: 1.h,
              indent: 16.w,
              endIndent: 16.w,
            );
          }
          return children[index ~/ 2];
        }),
      ),
    );
  }
}
