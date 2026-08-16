import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../shared/model/deal_model.dart';
import 'merchant_offer_meta.dart';

class MerchantOfferInfo extends StatelessWidget {
  final DealModel deal;

  const MerchantOfferInfo({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            deal.title.capitalizeWords(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(16.h),
          MerchantOfferMeta(deal: deal),
        ],
      ),
    );
  }
}
