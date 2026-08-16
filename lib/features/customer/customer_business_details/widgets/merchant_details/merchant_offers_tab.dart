import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';

import '../../../../../utils/enum/app_enum.dart';
import '../../controller/customer_business_details_controller.dart';
import '../tab_modulars/offer_tab_content/merchant_offers_list.dart';

class MerchantOffersTab extends StatelessWidget {
  const MerchantOffersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Obx(
      () => ApiStatusBuilder(
        status: controller.offersPaginator.status.value,
        errorMessage: controller.offersPaginator.errorMessage.value,
        onRetry: controller.refreshOffers,

        isLoadingMore:
            controller.offersPaginator.loadMoreStatus.value ==
            ApiStatus.loading,

        hasMore: controller.offersPaginator.hasMore.value,

        builder: (_) => const MerchantOffersList(),
      ),
    );
  }
}
