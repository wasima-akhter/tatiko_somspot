import 'package:som_spot/features/customer/customer_business_details/widgets/merchant_details/merchant_about_tab.dart';
import 'package:som_spot/features/customer/customer_business_details/widgets/merchant_details/merchant_offers_tab.dart';
import 'package:som_spot/features/customer/customer_business_details/widgets/merchant_details/merchant_reviews_tab.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../controller/customer_business_details_controller.dart';
import 'customer_business_details_tab_bar.dart';

class MerchantDetailsContent extends StatelessWidget {
  const MerchantDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MerchantDetailsTabBar(),
        Gap(16.h),
        Expanded(child: const MerchantDetailsTabContent()),
      ],
    );
  }
}

class MerchantDetailsTabContent extends StatelessWidget {
  const MerchantDetailsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = CustomerBusinessDetailsController.to;

      switch (controller.activeTabIndex.value) {
        case 0:
          return const MerchantAboutTab();

        case 1:
          return const MerchantOffersTab();

        case 2:
          return const MerchantReviewsTab();

        default:
          return const SizedBox.shrink();
      }
    });
  }
}
