import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/widgets/custom_buttom_sheet/custom_buttom_sheet.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../../../core/custom_assets/assets.gen.dart';
import '../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/other_controller.dart';

class AboutSomSpotScreen extends StatelessWidget {
  const AboutSomSpotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OtherController.to;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorNew,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title: Text(
          AppStrings.aboutSomSpot.tr,
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),

        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    Gap(24.h),

                    // App Logo Section (Visual Masterpiece)
                    Center(
                      child: Column(
                        children: [
                          Assets.images.splashlogo.image(),

                          Gap(4.h),
                          Text(
                            "Version 1.0.0",
                            style: context.bodySmall.copyWith(
                              color: AppColors.hintTextColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(32.h),

                    // Description Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.backgroundsLinesColor.withValues(
                            alpha: 0.8,
                          ),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.01),
                            blurRadius: 8.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: Obx(
                        () => ApiStatusBuilder(
                          status: controller.aboutLoading.value,
                          errorMessage: controller.errorMessage.value,
                          onRetry: controller.getAboutUs,

                          builder: (context) {
                            return Html(
                              data: controller.aboutDescription.value,

                              style: {
                                "body": Style(
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero,
                                  color: AppColors.subtitleTextColor,
                                  fontSize: FontSize(13.sp),
                                  lineHeight: LineHeight(1.5),
                                ),
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Gap(24.h),

                    // Navigation Links List Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.backgroundsLinesColor.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          _buildLinkTile(
                            context: context,
                            title: AppStrings.privacyPolicy.tr,
                            onTap: () {
                              AppToast.info(
                                context: context,
                                message: AppStrings.navigatingToPrivacy.tr,
                              );

                              AppRouter.route.pushNamed(
                                RoutePath.privacyPolicyScreen,
                              );
                            },
                          ),

                          _buildDivider(),

                          _buildLinkTile(
                            context: context,
                            title: AppStrings.termsConditions.tr,
                            onTap: () {
                              AppToast.info(
                                context: context,
                                message: AppStrings.navigatingToTerms.tr,
                              );

                              AppRouter.route.pushNamed(
                                RoutePath.termsAndConditionsScreen,
                              );
                            },
                          ),

                          _buildDivider(),

                          _buildLinkTile(
                            context: context,
                            title: "Rate the App",
                            onTap: () {
                              showRatingBottomSheet(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer (Made with Love in Mogadishu)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: Text(
                  AppStrings.madeWithLove.tr,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.hintTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinkTile({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 44.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
              ),

              Icon(
                Iconsax.arrow_right_3,
                size: 14.sp,
                color: const Color(0xff9AA8B8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.backgroundsLinesColor.withValues(alpha: 0.4),
    );
  }
}
