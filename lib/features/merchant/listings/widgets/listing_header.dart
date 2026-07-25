import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

class ListingHeader extends StatelessWidget {
  const ListingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 16.h,
        left: 20.w,
        right: 20.w,
        bottom: 24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.myListings.tr,
            style: context.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(4.h),
          Text(
            AppStrings.manageYourBusinessProfile.tr,
            style: context.bodyMedium.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
