import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class ApplicationSubmittedScreen extends StatelessWidget {
  const ApplicationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              const Spacer(),

              // ── Green Check Circle ──
              Center(
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.success,
                          width: 2.5,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        color: AppColors.success,
                        size: 28.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Gap(40.h),

              // ── Title ──
              Text(
                AppStrings.applicationSubmitted.tr,
                textAlign: TextAlign.center,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(16.h),

              // ── Description ──
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  AppStrings.applicationSubmittedDesc.tr,
                  textAlign: TextAlign.center,
                  style: context.bodyLarge.copyWith(
                    color: AppColors.subtitleTextColor,
                    height: 1.5,
                  ),
                ),
              ),

              const Spacer(),

              // ── Bottom Button ──
              CustomButton(
                text: AppStrings.viewStatus.tr,
                onTap: () {
                  AppRouter.route.goNamed(
                    RoutePath.applicationUnderReviewScreen,
                  );
                },
              ),
              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
