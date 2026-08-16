import 'package:som_spot/share/export/screen_export.dart';

import '../../../controller/customer_business_details_controller.dart';
import 'merchant_about_info_row.dart';
import 'merchant_about_skeleton.dart';
import 'merchant_opening_hours.dart';
import 'merchant_whatsapp_section.dart';

class MerchantAboutDetailsCard extends StatelessWidget {
  const MerchantAboutDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Obx(() {
      final business = controller.business.value;

      if (business == null) {
        return const MerchantAboutDetailsCardSkeleton();
      }

      return Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          children: [
            if (business.address.trim().isNotEmpty) ...[
              MerchantAboutInfoRow(
                icon: Icons.location_on_outlined,
                title: business.address.trim(),
              ),
            ],

            if (business.address.trim().isNotEmpty)
              const Divider(height: 24, color: AppColors.backgroundsLinesColor),

            MerchantAboutOpeningHours(),

            if (business.phone.trim().isNotEmpty) ...[
              const Divider(height: 24, color: AppColors.backgroundsLinesColor),
              MerchantAboutInfoRow(
                icon: Icons.phone_outlined,
                title: business.phone.trim(),
              ),
            ],

            MerchantAboutWhatsApp(),
          ],
        ),
      );
    });
  }
}

class MerchantAboutDetailsCardSkeleton extends StatelessWidget {
  const MerchantAboutDetailsCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: const Column(
        children: [
          MerchantAboutSkeletonInfoRow(),

          Divider(height: 24, color: AppColors.backgroundsLinesColor),

          MerchantAboutSkeletonInfoRow(titleWidth: 90, subtitleWidth: 130),

          Divider(height: 24, color: AppColors.backgroundsLinesColor),

          MerchantAboutSkeletonInfoRow(titleWidth: 160, showSubtitle: false),

          Divider(height: 24, color: AppColors.backgroundsLinesColor),

          MerchantAboutSkeletonInfoRow(titleWidth: 150, showSubtitle: false),
        ],
      ),
    );
  }
}
