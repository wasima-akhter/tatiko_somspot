import 'package:som_spot/core/custom_assets/assets.gen.dart';
import 'package:som_spot/features/customer/customer_home/controller/merchant_details_controller.dart';
import 'package:som_spot/features/customer/customer_home/model/merchant_model.dart';
import 'package:som_spot/features/customer/customer_home/widgets/merchant_details/merchant_about_tab.dart';
import 'package:som_spot/features/customer/customer_home/widgets/merchant_details/merchant_header_backdrop.dart';
import 'package:som_spot/features/customer/customer_home/widgets/merchant_details/merchant_offers_tab.dart';
import 'package:som_spot/features/customer/customer_home/widgets/merchant_details/merchant_reviews_tab.dart';
import 'package:som_spot/features/customer/customer_home/widgets/merchant_details/merchant_sticky_footer.dart';
import 'package:som_spot/helper/launcher/launcher_helper.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/controller/screen_export.dart';

class MerchantDetailsScreen extends StatelessWidget {
  final MerchantModel merchant;

  const MerchantDetailsScreen({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    // Put or Find the controller
    final controller = Get.put(MerchantDetailsController());

    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      body: Stack(
        children: [
          // Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Backdrop Stack
                  MerchantHeaderBackdrop(merchant: merchant),
                  Gap(16.h),

                  // Custom Tab Bar Row
                  _buildTabBarRow(context, controller),
                  Gap(16.h),

                  // Tab Content
                  Obx(() {
                    switch (controller.activeTabIndex.value) {
                      case 0:
                        return MerchantAboutTab(merchant: merchant);
                      case 1:
                        return MerchantOffersTab(controller: controller);
                      case 2:
                        return MerchantReviewsTab(controller: controller);
                      default:
                        return const SizedBox.shrink();
                    }
                  }),
                ],
              ),
            ),
          ),

          // Custom Positioned Floating AppBar
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularActionButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.of(context).pop(),
                ),
                Row(
                  children: [
                    _buildCircularActionButton(
                      icon: Icons.share_outlined,
                      onTap: () {
                        LauncherHelper.shareMerchant(
                          context,
                          title: merchant.title,
                          category: merchant.category,
                        );
                      },
                    ),
                    Gap(8.w),
                    _buildCircularActionButton(
                      icon: Icons.bookmark_border_rounded,
                      onTap: () {
                        AppToast.success(
                          context: context,
                          message:
                              "${merchant.title} ${AppStrings.savedToBookmarks.tr}",
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Sticky Footer Actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MerchantStickyFooter(merchant: merchant),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18.sp),
      ),
    );
  }

  Widget _buildTabBarRow(
    BuildContext context,
    MerchantDetailsController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 5.r,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Obx(() {
                return Row(
                  children: [
                    _buildTabItem(
                      context,
                      controller,
                      index: 0,
                      title: AppStrings.about.tr,
                    ),
                    _buildTabItem(
                      context,
                      controller,
                      index: 1,
                      title: AppStrings.offers.tr,
                    ),
                    _buildTabItem(
                      context,
                      controller,
                      index: 2,
                      title: AppStrings.reviews.tr,
                    ),
                  ],
                );
              }),
            ),
          ),
          Gap(12.w),
          // WhatsApp circular launcher icon
          GestureDetector(
            onTap: () {
              LauncherHelper.launchWhatsApp(context, "+8801862110104");
            },
            child: Assets.icons.whatsapps.svg(height: 48.h, width: 48.w),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    MerchantDetailsController controller, {
    required int index,
    required String title,
  }) {
    final isSelected = controller.activeTabIndex.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.activeTabIndex.value = index,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: context.bodyMedium.copyWith(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.subtitleTextColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
