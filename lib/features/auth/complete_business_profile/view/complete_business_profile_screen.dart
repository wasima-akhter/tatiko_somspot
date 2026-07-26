import 'package:som_spot/features/auth/complete_business_profile/controller/complete_business_profile_controller.dart';
import 'package:som_spot/features/auth/complete_business_profile/view/widgets/branding_step.dart';
import 'package:som_spot/features/auth/complete_business_profile/view/widgets/business_hours_step.dart';
import 'package:som_spot/features/auth/complete_business_profile/view/widgets/business_info_step.dart';
import 'package:som_spot/features/auth/complete_business_profile/view/widgets/contact_step.dart';
import 'package:som_spot/features/auth/complete_business_profile/view/widgets/location_step.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../core/category/controller/category_controller.dart';

class CompleteBusinessProfileScreen extends StatefulWidget {
  const CompleteBusinessProfileScreen({super.key});

  @override
  State<CompleteBusinessProfileScreen> createState() =>
      _CompleteBusinessProfileScreenState();
}

class _CompleteBusinessProfileScreenState
    extends State<CompleteBusinessProfileScreen> {
  final controller = CompleteBusinessProfileController.to;

  final categoryController = CategoryController.to;

  final selectedCategoryId = RxnString();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
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
                  mainAxisAlignment: MainAxisAlignment.start,
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

                    Gap(20.w),

                    // Custom progress dots indicator: active index is a capsule, inactive are dots
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(controller.totalSteps, (index) {
                        final isActive = controller.currentStep.value == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: isActive ? 24.w : 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primaryColor
                                : AppColors.primaryColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        );
                      }),
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
                    controller.currentStep.value == controller.totalSteps - 1;
                return Column(
                  children: [
                    CustomButton(
                      text: isLastStep
                          ? AppStrings.finishSetup.tr
                          : AppStrings.continueLabel.tr,
                      isLoading: controller.isLoading.value,
                      onTap: () async {
                        if (isLastStep) {
                          await controller.finishSetup();
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
