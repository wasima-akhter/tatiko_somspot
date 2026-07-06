import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';
import 'package:som_spot/features/profile/main_profile/view/widgets/language_dialog_content.dart';
import 'package:som_spot/features/profile/main_profile/view/widgets/profile_menu_card.dart';
import 'package:som_spot/features/profile/main_profile/view/widgets/profile_menu_item.dart';
import 'package:som_spot/features/profile/main_profile/view/widgets/profile_section_header.dart';
import 'package:som_spot/features/profile/main_profile/view/widgets/profile_stat_card.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/widgets/dialog/custom_dialog.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blue Curved Header Wave Banner
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24.r),
                ),
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
                  // User details row
                  Obx(() {
                    return Row(
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.w),
                          ),
                          child: ClipOval(
                            child: CustomNetworkImage(
                              imageUrl: controller.userAvatar.value,
                              boxShape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.userName.value,
                                style: context.titleMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Gap(2.h),
                              Text(
                                controller.userEmail.value,
                                style: context.bodyMedium.copyWith(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Edit Profile Icon Button
                        GestureDetector(
                          onTap: () => AppRouter.route.pushNamed(
                            RoutePath.editProfileScreen,
                          ),
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.22),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Iconsax.edit_2,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  Gap(20.h),
                  // Statistics cards
                  Obx(() {
                    if (CommonController.to.isMerchandiser) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6BB5FF),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.currentPlan.tr,
                                  style: context.bodyMedium.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                                Gap(4.h),
                                Text(
                                  AppStrings.proMonthly.tr,
                                  style: context.titleLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4A9DF7),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 0,
                                ),
                                minimumSize: Size(0, 36.h),
                              ),
                              child: Text(
                                AppStrings.upgrade.tr,
                                style: context.bodyMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Row(
                      children: [
                        ProfileStatCard(
                          label: AppStrings.saved.tr,
                          value: controller.savedCount.value,
                        ),
                        Gap(12.w),
                        ProfileStatCard(
                          label: AppStrings.claims.tr,
                          value: controller.claimsCount.value,
                        ),
                        Gap(12.w),
                        ProfileStatCard(
                          label: AppStrings.reviews.tr,
                          value: controller.reviewsCount.value,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Scrollable Menu Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account section
                  ProfileSectionHeader(title: AppStrings.account.tr),
                  Gap(8.h),
                  ProfileMenuCard(
                    children: [
                      ProfileMenuItem(
                        icon: Iconsax.user_edit,
                        title: AppStrings.editProfile.tr,
                        onTap: () => AppRouter.route.pushNamed(
                          RoutePath.editProfileScreen,
                        ),
                      ),
                      Obx(() {
                        if (CommonController.to.isMerchandiser) {
                          return Column(
                            children: [
                              ProfileMenuItem(
                                icon: Iconsax.shop,
                                title: AppStrings.businessInfo.tr,
                                onTap: () {
                                  AppRouter.route.pushNamed(
                                    RoutePath.businessInfoScreen,
                                  );
                                },
                              ),
                              ProfileMenuItem(
                                icon: Iconsax.card,
                                title: AppStrings.subscriptionBilling.tr,
                                onTap: () {
                                  AppRouter.route.pushNamed(
                                    RoutePath.subscriptionScreen,
                                  );
                                },
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            ProfileMenuItem(
                              icon: Iconsax.archive_1,
                              title: AppStrings.savedItems.tr,
                              onTap: () {
                                AppToast.info(
                                  context: context,
                                  message:
                                      "You can view saved items from the Saved tab.",
                                );
                                NavigationControllerMain
                                        .to
                                        .selectedNavIndex
                                        .value =
                                    2;
                              },
                            ),
                            ProfileMenuItem(
                              icon: Iconsax.ticket,
                              title: AppStrings.myClaims.tr,
                              onTap: () => AppRouter.route.pushNamed(
                                RoutePath.claimsScreen,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  Gap(20.h),

                  // Preferences section
                  ProfileSectionHeader(title: AppStrings.preferences.tr),
                  Gap(8.h),
                  ProfileMenuCard(
                    children: [
                      ProfileMenuItem(
                        icon: Iconsax.global,
                        title: AppStrings.language.tr,
                        onTap: () => _showLanguageDialog(context),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.lock,
                        title: AppStrings.changePassword.tr,
                        onTap: () {
                          AppToast.info(
                            context: context,
                            message: "Change password option coming soon.",
                          );
                          AppRouter.route.pushNamed(
                            RoutePath.changePasswordScreen,
                          );
                        },
                      ),
                    ],
                  ),
                  Gap(20.h),

                  // Support section
                  ProfileSectionHeader(title: AppStrings.support.tr),
                  Gap(8.h),
                  ProfileMenuCard(
                    children: [
                      ProfileMenuItem(
                        icon: Iconsax.message_question,
                        title: AppStrings.helpSupport.tr,
                        onTap: () => AppRouter.route.pushNamed(
                          RoutePath.helpAndSupportScreen,
                        ),
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.info_circle,
                        title: AppStrings.aboutSomSpot.tr,
                        onTap: () => AppRouter.route.pushNamed(
                          RoutePath.aboutSomSpotScreen,
                        ),
                      ),
                    ],
                  ),
                  Gap(24.h),

                  // Log Out Button
                  GestureDetector(
                    onTap: () => _showLogoutDialog(context, controller),
                    child: Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.logout,
                            color: AppColors.error,
                            size: 20.sp,
                          ),
                          Gap(8.w),
                          Text(
                            AppStrings.logOut.tr,
                            style: context.titleMedium.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
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

  void _showLogoutDialog(
    BuildContext context,
    ProfileScreenController controller,
  ) {
    AppDialog.show(
      context: context,
      type: AppDialogType.error,
      title: AppStrings.areYouSureLogout.tr,
      subtitle: AppStrings.logoutWarning.tr,
      showDefaultButtons: true,
      confirmText: AppStrings.yes.tr,
      cancelText: AppStrings.cancel.tr,
      onConfirm: () => controller.logout(),
      onCancel: () {},
    );
  }

  void _showLanguageDialog(BuildContext context) {
    AppDialog.show(
      context: context,
      type: AppDialogType.custom,
      title: AppStrings.selectLanguage.tr,
      dismissible: true,
      content: const LanguageDialogContent(),
    );
  }
}
