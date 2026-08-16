import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';
import 'package:som_spot/features/profile/main_profile/widgets/language_dialog_content.dart';
import 'package:som_spot/features/profile/main_profile/widgets/profile_menu_card.dart';
import 'package:som_spot/features/profile/main_profile/widgets/profile_menu_item.dart';
import 'package:som_spot/features/profile/main_profile/widgets/profile_section_header.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/widgets/dialog/custom_dialog.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/refresh_indicator/refresh_indicator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../widgets/influencer_edit_option_bottom_sheet.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await controller.getProfile();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blue Curved Header Wave Banner
              ProfileHeader(),
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

                          onTap: () {
                            final role = CommonController.to.role.value;

                            switch (role) {
                              case UserRole.merchandiser:
                                AppRouter.route.pushNamed(
                                  RoutePath.editProfileScreen,
                                );

                                break;

                              case UserRole.influencer:
                                showInfluencerEditBottomSheet(context);

                                break;

                              case UserRole.customer:
                                AppRouter.route.pushNamed(
                                  RoutePath.editCustomerProfileScreen,
                                );

                                break;
                            }
                          },
                        ),
                        Obx(() {
                          final commonController = CommonController.to;

                          // Merchandiser Menu
                          if (commonController.isMerchandiser) {
                            return Column(
                              children: [
                                // ProfileMenuItem(
                                //   icon: Iconsax.shop,
                                //   title: AppStrings.businessInfo.tr,
                                //   onTap: () {
                                //     AppRouter.route.pushNamed(
                                //       RoutePath.businessInfoScreen,
                                //     );
                                //   },
                                // ),
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

                          // Influencer Menu
                          if (commonController.isInfluencer) {
                            // return Column(
                            //   children: [
                            //     ProfileMenuItem(
                            //       icon: Icons.bookmark_outline_rounded,
                            //       title: "My Campaigns",
                            //       onTap: () {
                            //         AppRouter.route.pushNamed(
                            //           RoutePath.influencerMyCampaigns,
                            //         );
                            //       },
                            //     ),
                            //   ],
                            // );
                          }

                          // Customer Menu
                          if (commonController.isCustomer) {
                            return Column(
                              children: [
                                // ProfileMenuItem(
                                //   icon: Iconsax.archive_1,
                                //   title: AppStrings.savedItems.tr,
                                //   onTap: () {
                                //     AppToast.info(
                                //       context: context,
                                //       message:
                                //           "You can view saved items from the Saved tab.",
                                //     );

                                //     NavigationControllerMain
                                //             .to
                                //             .selectedNavIndex
                                //             .value =
                                //        3;
                                //   },
                                // ),

                                // ProfileMenuItem(
                                //   icon: Iconsax.ticket,
                                //   title: AppStrings.myClaims.tr,
                                //   onTap: () {
                                //     AppRouter.route.pushNamed(
                                //       RoutePath.claimsScreen,
                                //     );
                                //   },
                                // ),
                              ],
                            );
                          }

                          return const SizedBox.shrink();
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
                              message: AppStrings.loading.tr,
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
                      behavior: HitTestBehavior.opaque,
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
                    Gap(15.h),

                    Center(
                      child: Text(
                        "SomSpot v1.0.0",
                        style: context.bodySmall.copyWith(
                          color: AppColors.grayTextSecondaryColor,
                        ),
                      ),
                    ),

                    Gap(15.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showInfluencerEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,

      backgroundColor: Colors.transparent,

      isScrollControlled: true,

      builder: (_) => const InfluencerEditOptionBottomSheet(),
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
