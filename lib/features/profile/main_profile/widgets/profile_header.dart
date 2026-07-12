import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings/app_strings.dart';
import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import 'profile_statistics_section.dart';
import 'profile_user_info.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: AppColors.primaryColor,

        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),

      padding: EdgeInsets.fromLTRB(
        16.w,
        MediaQuery.of(context).padding.top + 16.h,
        16.w,
        24.h,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            AppStrings.profile.tr,

            style: context.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),

          Gap(16.h),

          const ProfileUserInfo(),

          Gap(20.h),

          const ProfileStatisticsSection(),
        ],
      ),
    );
  }
}
