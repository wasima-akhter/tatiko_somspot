import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class ApplicationUnderReviewScreen extends StatelessWidget {
  const ApplicationUnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Top Header Area (Blue Background) ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 40.h),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  // Hourglass Icon with double circles
                  Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 8,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.hourglass_empty_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  Gap(16.h),

                  // Under Review Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Gap(8.w),
                        Text(
                          AppStrings.underReviewBadge.tr,
                          style: context.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(16.h),

                  // Title
                  Text(
                    AppStrings.applicationUnderReview.tr,
                    textAlign: TextAlign.center,
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(12.h),

                  // Description
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      AppStrings.applicationUnderReviewDesc.tr,
                      textAlign: TextAlign.center,
                      style: context.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Body Content ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Estimated Time Card
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.08,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.clock,
                            color: AppColors.primaryColor,
                            size: 24.sp,
                          ),
                        ),
                        Gap(16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.estimatedTime.tr,
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.subtitleTextColor,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                AppStrings.estimatedTimeDesc.tr,
                                style: context.bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            AppStrings.estimatedTimeBadge.tr,
                            style: context.bodySmall.copyWith(
                              color: const Color(0xFFD97706),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(24.h),

                  // 2. Approval Progress Section
                  Text(
                    AppStrings.approvalProgress.tr,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  Gap(16.h),

                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildTimelineItem(
                          context: context,
                          icon: _buildSuccessIcon(),
                          title: AppStrings.profileSubmitted.tr,
                          subtitle: AppStrings.todayJustNow.tr,
                          badge: _buildStatusBadge(
                            text: AppStrings.doneBadge.tr,
                            textColor: AppColors.success,
                            bgColor: AppColors.success.withValues(alpha: 0.1),
                          ),
                          showLine: true,
                        ),
                        _buildTimelineItem(
                          context: context,
                          icon: _buildInProgressIcon(),
                          title: AppStrings.adminReview.tr,
                          subtitle: AppStrings.inProgress.tr,
                          badge: _buildStatusBadge(
                            text: AppStrings.currentBadge.tr,
                            textColor: AppColors.primaryColor,
                            bgColor: AppColors.primaryColor.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          showLine: true,
                        ),
                        _buildTimelineItem(
                          context: context,
                          icon: _buildPendingIcon(),
                          title: AppStrings.approvalAccess.tr,
                          subtitle: AppStrings.awaitingReview.tr,
                          showLine: false,
                        ),
                      ],
                    ),
                  ),
                  Gap(24.h),

                  // 3. What we're verifying Section
                  Text(
                    AppStrings.whatWeAreVerifying.tr,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  Gap(16.h),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildVerifyingItem(
                          context: context,
                          icon: Iconsax.shop,
                          iconColor: const Color(0xFF10B981),
                          iconBgColor: const Color(0xFFECFDF5),
                          title: AppStrings.businessProfile.tr,
                          subtitle: AppStrings.businessProfileDesc.tr,
                          statusWidget: _buildGreenCheck(),
                        ),
                        const Divider(
                          color: AppColors.backgroundsLinesColor,
                          height: 1,
                        ),
                        _buildVerifyingItem(
                          context: context,
                          icon: Iconsax.location,
                          iconColor: const Color(0xFF10B981),
                          iconBgColor: const Color(0xFFECFDF5),
                          title: AppStrings.addressLocation.tr,
                          subtitle: AppStrings.addressLocationDesc.tr,
                          statusWidget: _buildGreenCheck(),
                        ),
                        const Divider(
                          color: AppColors.backgroundsLinesColor,
                          height: 1,
                        ),
                        _buildVerifyingItem(
                          context: context,
                          icon: Iconsax.call,
                          iconColor: AppColors.primaryColor,
                          iconBgColor: AppColors.primaryColor.withValues(
                            alpha: 0.08,
                          ),
                          title: AppStrings.contactInformation.tr,
                          subtitle: AppStrings.contactInformationDesc.tr,
                          statusWidget: _buildBlueSync(),
                        ),
                        const Divider(
                          color: AppColors.backgroundsLinesColor,
                          height: 1,
                        ),
                        _buildVerifyingItem(
                          context: context,
                          icon: Iconsax.document,
                          iconColor: AppColors.subtitleTextColor,
                          iconBgColor: const Color(0xFFF3F4F6),
                          title: AppStrings.businessDocuments.tr,
                          subtitle: AppStrings.businessDocumentsDesc.tr,
                        ),
                      ],
                    ),
                  ),
                  Gap(24.h),

                  // 4. Why verification Card
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Iconsax.shield_security,
                          color: AppColors.primaryColor,
                          size: 24.sp,
                        ),
                        Gap(16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.whyVerificationTitle.tr,
                                style: context.bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Gap(6.h),
                              Text(
                                AppStrings.whyVerificationDesc.tr,
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.darkTextColor,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(32.h),

                  // 5. Log Out Button
                  GestureDetector(
                    onTap: () {
                      AppRouter.route.goNamed(RoutePath.welcomeScreen);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: AppColors.backgroundsLinesColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: AppColors.error,
                            size: 20.sp,
                          ),
                          Gap(10.w),
                          Text(
                            AppStrings.logOut.tr,
                            style: context.bodyLarge.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helper Widgets ──

  Widget _buildTimelineItem({
    required BuildContext context,
    required Widget icon,
    required String title,
    required String subtitle,
    Widget? badge,
    required bool showLine,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              icon,
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2.w,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    color: AppColors.backgroundsLinesColor,
                  ),
                ),
            ],
          ),
          Gap(16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkTextColor,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        subtitle,
                        style: context.bodyMedium.copyWith(
                          color: AppColors.subtitleTextColor,
                        ),
                      ),
                    ],
                  ),
                  badge ?? const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyingItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    Widget? statusWidget,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                ),
                Gap(4.h),
                Text(
                  subtitle,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ),
          ),
          statusWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: const BoxDecoration(
        color: AppColors.success,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check, color: AppColors.white, size: 14),
    );
  }

  Widget _buildInProgressIcon() {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
      ),
      child: const Icon(
        Icons.sync_rounded,
        color: AppColors.primaryColor,
        size: 12,
      ),
    );
  }

  Widget _buildPendingIcon() {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.subtitleTextColor.withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            color: AppColors.subtitleTextColor.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge({
    required String text,
    required Color textColor,
    required Color bgColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildGreenCheck() {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check, color: Color(0xFF10B981), size: 12),
    );
  }

  Widget _buildBlueSync() {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.sync_rounded,
        color: AppColors.primaryColor,
        size: 12,
      ),
    );
  }
}
