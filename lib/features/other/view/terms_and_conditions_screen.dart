import 'package:flutter_html/flutter_html.dart';

import '../../../share/export/screen_export.dart';
import '../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/other_controller.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OtherController.to;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.getTermsConditions();
    });

    return ScaffoldWrapper(
      title: AppStrings.termsConditions.tr,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(24.h),

              // ── Content Card ──
              Expanded(
                child: Obx(() {
                  return ApiStatusBuilder(
                    status: controller.termsLoading.value,
                    errorMessage: controller.errorMessage.value,
                    onRetry: controller.getTermsConditions,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
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
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   AppStrings.termsOfService.tr,
                              //   style: context.titleLarge.copyWith(
                              //     fontWeight: FontWeight.bold,
                              //     color: AppColors.darkTextColor,
                              //     fontSize: 18.sp,
                              //   ),
                              // ),
                              // Gap(4.h),
                              // Text(
                              //   // Dynamic: will come from server
                              //   "Effective April 2026",
                              //   style: context.bodySmall.copyWith(
                              //     color: AppColors.subtitleTextColor.withValues(
                              //       alpha: 0.7,
                              //     ),
                              //     fontSize: 12.sp,
                              //   ),
                              // ),
                              // Gap(20.h),
                              Html(
                                data: controller.termsDescription.value,
                                style: {
                                  "body": Style(
                                    color: AppColors.subtitleTextColor,
                                    fontSize: FontSize(14.sp),
                                    lineHeight: LineHeight(1.5),
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
