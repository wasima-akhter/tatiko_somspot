import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_spot/utils/color/app_colors.dart';

class ProfileSectionHeader extends StatelessWidget {
  final String title;

  const ProfileSectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.subtitleTextColor,
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      ),
    );
  }
}
