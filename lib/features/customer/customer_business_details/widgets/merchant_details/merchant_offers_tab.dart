import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';

import '../../../../../utils/enum/app_enum.dart';
import '../../controller/customer_business_details_controller.dart';
import '../tab_modulars/offer_tab_content/merchant_offers_list.dart';

class MerchantOffersTab extends StatelessWidget {
  const MerchantOffersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status:
            CustomerBusinessDetailsController.to.offersPaginator.status.value,
        errorMessage: CustomerBusinessDetailsController
            .to
            .offersPaginator
            .errorMessage
            .value,
        onRetry: CustomerBusinessDetailsController.to.refreshOffers,
        isLoadingMore:
            CustomerBusinessDetailsController
                .to
                .offersPaginator
                .loadMoreStatus
                .value ==
            ApiStatus.loading,
        hasMore:
            CustomerBusinessDetailsController.to.offersPaginator.hasMore.value,
        builder: (_) => const MerchantOffersList(),
      ),
    );
  }
}
