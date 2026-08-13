import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';

import '../../../../../../utils/enum/app_enum.dart';
import '../../../controller/customer_business_details_controller.dart';
import 'merchant_offer_card.dart';

class MerchantOffersList extends StatelessWidget {
  const MerchantOffersList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Obx(() {
      final offers = controller.merchantOffers;
      final paginator = controller.offersPaginator;

      final isLoadingMore = paginator.loadMoreStatus.value == ApiStatus.loading;

      final showEndOfList = !paginator.hasMore.value && offers.isNotEmpty;

      final extraItems = (isLoadingMore ? 1 : 0) + (showEndOfList ? 1 : 0);

      return SizedBox(
        height: 1.sh * 0.4,
        child: CustomRefreshIndicator(
          onRefresh: controller.refreshOffers,
          child: ListView.separated(
            controller: controller.listScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 32.h),
            itemCount: offers.length + extraItems,
            separatorBuilder: (_, index) {
              if (index >= offers.length - 1) {
                return const SizedBox.shrink();
              }

              return Gap(14.h);
            },
            itemBuilder: (context, index) {
              if (index < offers.length) {
                return MerchantOfferCard(deal: offers[index]);
              }

              if (isLoadingMore) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(
                  child: Text(
                    "No more offers",
                    style: context.bodySmall.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
