import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/auth/completed_profile/controller/completed_profile_controller.dart';
import 'package:som_spot/features/auth/completed_profile/view/widgets/branding_step.dart';
import 'package:som_spot/features/auth/completed_profile/view/widgets/business_hours_step.dart';
import 'package:som_spot/features/auth/completed_profile/view/widgets/business_info_step.dart';
import 'package:som_spot/features/auth/completed_profile/view/widgets/contact_step.dart';
import 'package:som_spot/features/auth/completed_profile/view/widgets/location_step.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class CompletedProfileScreen extends StatefulWidget {
  const CompletedProfileScreen({super.key});

  @override
  State<CompletedProfileScreen> createState() => _CompletedProfileScreenState();
}

class _CompletedProfileScreenState extends State<CompletedProfileScreen> {
  final controller = Get.put(CompletedProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Column(
          children: [
            Gap(16.h),

            // ── Top Bar: Back + Custom Step Dots + Skip ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () {
                        if (controller.currentStep.value > 0) {
                          controller.previousStep();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.backgroundsLinesColor,
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 16.sp,
                          color: AppColors.darkTextColor,
                        ),
                      ),
                    ),

                    // Custom progress dots indicator: active index is a capsule, inactive are dots
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        CompletedProfileController.totalSteps,
                        (index) {
                          final isActive =
                              controller.currentStep.value == index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: isActive ? 24.w : 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor.withValues(
                                      alpha: 0.2,
                                    ),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          );
                        },
                      ),
                    ),

                    // Skip button
                    GestureDetector(
                      onTap: () {
                        AppRouter.route.goNamed(RoutePath.navigationPages);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.2,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          AppStrings.skip.tr,
                          style: context.bodySmall.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(20.h),

            // ── Page Content ──
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  BusinessInfoStep(),
                  LocationStep(),
                  BusinessHoursStep(),
                  BrandingStep(),
                  ContactStep(),
                ],
              ),
            ),

            // ── Bottom Button ──
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
              child: Obx(() {
                final isLastStep =
                    controller.currentStep.value ==
                    CompletedProfileController.totalSteps - 1;
                return Column(
                  children: [
                    CustomButton(
                      text: isLastStep
                          ? AppStrings.finishSetup.tr
                          : AppStrings.continueLabel.tr,
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        if (isLastStep) {
                          controller.finishSetup().then((_) {
                            AppRouter.route.goNamed(
                              RoutePath.applicationSubmittedScreen,
                            );
                          });
                        } else {
                          controller.nextStep();
                        }
                      },
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
