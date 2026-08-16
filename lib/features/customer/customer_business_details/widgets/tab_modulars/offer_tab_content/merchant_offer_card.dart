import 'package:som_spot/share/export/screen_export.dart';

import '../../../../../offers/offer_details/controller/offer_detail_controller.dart';
import '../../../../../offers/offer_details/helper/offer_details_arg_model.dart';
import '../../../shared/model/deal_model.dart';
import 'merchant_offer_image.dart';
import 'merchant_offer_info.dart';

class MerchantOfferCard extends StatelessWidget {
  final DealModel deal;

  const MerchantOfferCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleOfferTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            MerchantOfferImage(deal: deal),
            Gap(12.w),
            Expanded(child: MerchantOfferInfo(deal: deal)),
          ],
        ),
      ),
    );
  }

  void _handleOfferTap() {
    if (Get.isRegistered<OfferDetailController>()) {
      Get.delete<OfferDetailController>();
    }

    AppRouter.route.pushNamed(
      RoutePath.offerDetailsScreen,
      extra: OfferDetailsArgs(offerId: deal.id, isFromClaim: true),
    );
  }
}
