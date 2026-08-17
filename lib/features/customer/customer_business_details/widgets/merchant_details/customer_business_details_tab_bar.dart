import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/core/custom_assets/assets.gen.dart';
import 'package:som_spot/helper/launcher/launcher_helper.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../../utils/enum/app_enum.dart';
import '../../controller/customer_business_details_controller.dart';
import 'customer_business_details_tab_item.dart';

class MerchantDetailsTabBar extends StatelessWidget {
  const MerchantDetailsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Row(
                children: [
                  MerchantDetailsTabItem(index: 0, title: AppStrings.about.tr),
                  MerchantDetailsTabItem(index: 1, title: AppStrings.offers.tr),
                  MerchantDetailsTabItem(
                    index: 2,
                    title: AppStrings.reviews.tr,
                  ),
                ],
              ),
            ),
          ),
          Gap(12.w),
          _buildWhatsAppSection(context),
        ],
      ),
    );
  }

  Widget _buildWhatsAppSection(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;
    return Obx(() {
      final status = controller.businessStatus.value;

      // Loading
      if (status == ApiStatus.loading) {
        return const _WhatsAppShimmer();
      }

      final business = controller.business.value;

      if (business == null || business.whatsapp.trim().isEmpty) {
        return const SizedBox.shrink();
      }

      final whatsapp = business.whatsapp.trim();

      return Column(
        children: [
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  LauncherHelper.launchWhatsApp(context, whatsapp);
                },
                child: Assets.icons.whatsapps.svg(height: 48.h, width: 48.w),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class _WhatsAppShimmer extends StatelessWidget {
  const _WhatsAppShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 24, color: AppColors.backgroundsLinesColor),

        Row(
          children: [
            // WhatsApp button shimmer
            AutoShimmerAnimate(
              isLoading: true,
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
