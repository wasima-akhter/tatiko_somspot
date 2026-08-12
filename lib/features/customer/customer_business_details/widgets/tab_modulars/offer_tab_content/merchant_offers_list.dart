import 'package:som_spot/share/controller/screen_export.dart';

import '../../../controller/customer_business_details_controller.dart';
import 'merchant_offer_card.dart';

class MerchantOffersList extends StatelessWidget {
  const MerchantOffersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;
    final offers = controller.merchantOffers;

    if (offers.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(24.r),
        child: Center(
          child: Text(
            AppStrings.noActiveOffers.tr,
            style: context.bodyMedium.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      controller: controller.listScrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: offers.length,
      separatorBuilder: (_, _) => Gap(14.h),
      itemBuilder: (context, index) {
        return MerchantOfferCard(deal: offers[index]);
      },
    );
  }
}
