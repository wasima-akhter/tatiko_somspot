import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/common_controller/common_controller.dart';
import '../controller/offer_detail_controller.dart';
import '../shimmer/offer_details_shimmer.dart';
import '../widgets/offer_details_action_button.dart';
import '../widgets/offer_details_primary_card.dart';
import '../widgets/offer_details_terms_card.dart';

class OfferDetailsScreen extends GetView<OfferDetailController> {
  final String offerId;

  const OfferDetailsScreen({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.softBackgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,

        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.darkTextColor,
            size: 20.sp,
          ),
        ),

        title: Text(
          AppStrings.offerDetails.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkTextColor,
          ),
        ),

        titleSpacing: 0,
      ),

      body: Obx(
        () => ApiStatusBuilder(
          status: controller.status.value,
          errorMessage: controller.errorMessage.value,
          onRetry: controller.refreshOffer,

          loadingWidget: const OfferDetailsShimmer(),

          builder: (_) {
            final offer = controller.offer.value!;

            return CustomRefreshIndicator(
              onRefresh: () async {
                await controller.refreshOffer();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),

                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),

                child: Column(
                  children: [
                    OfferDetailsPrimaryCard(offer: offer),

                    Gap(16.h),

                    OfferDetailsTermsCard(offer: offer),

                    Gap(32.h),

                    if (CommonController.to.isMerchandiser &&
                        offer.status == "scheduled")
                      OfferDetailsActionButton(offer: offer),

                    Gap(40.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
