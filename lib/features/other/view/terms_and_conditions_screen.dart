import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.termsConditions.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: AppColors.darkTextColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(24.h),

              // ── Content Card ──
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.03),
                        blurRadius: 10.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.backgroundsLinesColor.withValues(
                        alpha: 0.8,
                      ),
                      width: 1,
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.termsOfService.tr,
                          style: context.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        Gap(4.h),
                        Text(
                          // Dynamic: will come from server
                          "Effective April 2026",
                          style: context.bodySmall.copyWith(
                            color: AppColors.subtitleTextColor.withValues(
                              alpha: 0.7,
                            ),
                            fontSize: 12.sp,
                          ),
                        ),
                        Gap(20.h),

                        // Dynamic: content will come from server
                        _buildParagraph(
                          context,
                          "By using SomSpot you agree to discover, claim, and review local businesses in good faith. Offers shown in the app are provided by merchants and subject to their individual terms and availability.",
                        ),
                        Gap(16.h),
                        _buildParagraph(
                          context,
                          "You are responsible for the accuracy of any information you submit and for keeping your account credentials secure. We may update these terms periodically and will notify you of material changes.",
                        ),
                        Gap(16.h),
                        _buildParagraph(
                          context,
                          "We never sell your personal information to third parties. You can request a copy of your data or delete your account at any time from Privacy & Security settings.",
                        ),
                        Gap(16.h),
                        _buildParagraph(
                          context,
                          "We never sell your personal information to third parties. You can request a copy of your data or delete your account at any time from Privacy & Security settings.",
                        ),
                        Gap(16.h),
                        _buildParagraph(
                          context,
                          "Misuse of claim codes or fraudulent activity may result in account suspension.",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: context.bodyMedium.copyWith(
        color: AppColors.subtitleTextColor,
        height: 1.5,
        fontSize: 14.sp,
      ),
    );
  }
}
