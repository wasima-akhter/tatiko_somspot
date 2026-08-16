import 'package:flutter_html/flutter_html.dart';

import '../../../share/export/screen_export.dart';
import '../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/other_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OtherController.to;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await controller.getPrivacyPolicy();
    });
    return ScaffoldWrapper(
      title: AppStrings.privacyPolicy.tr,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(24.h),

              // ── Content Card ──
              Expanded(
                child: Obx(() {
                  return ApiStatusBuilder(
                    status: controller.privacyLoading.value,
                    errorMessage: controller.errorMessage.value,
                    onRetry: controller.getPrivacyPolicy,

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
                          ),
                        ),

                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),

                          child: Html(
                            data: controller.privacyDescription.value,

                            style: {
                              "body": Style(
                                color: AppColors.subtitleTextColor,
                                fontSize: FontSize(14.sp),
                                lineHeight: LineHeight(1.5),
                              ),
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
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
