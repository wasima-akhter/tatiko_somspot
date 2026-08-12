import 'package:som_spot/features/customer/customer_business_details/controller/customer_business_details_controller.dart';
import 'package:som_spot/features/customer/customer_offer_claim/helper/customer_offer_claim_helper.dart';
import 'package:som_spot/features/offers/offer_details/controller/offer_detail_controller.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../share/controller/screen_export.dart';

class ClaimOfferNowButton extends StatelessWidget {
  const ClaimOfferNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OfferDetailController.to;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(color: AppColors.backgroundsLinesColor),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Obx(() {
        return SizedBox(
          width: double.infinity,
          height: 52.h,
          child: controller.claimStatus.value == ApiStatus.loading
              ? LoadingWidget()
              : ElevatedButton(
                  onPressed: () async {
                    final claim = await controller.claimOffer();

                    if (claim == null) {
                      return;
                    }

                    try {
                      // await controller.getOfferDetails();

                      controller.offer.update((offer) {
                        if (offer == null) return;

                        offer.isClaimed = true;
                      });
                    } catch (e) {
                      debugPrint('failed to update details');
                    }
                    AppRouter.route.pushNamed(
                      RoutePath.offerClaimScreen,
                      extra: OfferClaimArgs(
                        claimCode: controller.offer.value?.claimCode ?? '',
                      ),
                    );

                    if (Get.isRegistered<CustomerBusinessDetailsController>()) {
                      CustomerBusinessDetailsController.to.refreshOffers();
                    }

                    // update the offer list in business detail in customer portion

                    // then --> uypdate the claimed api. and
                    // reload this paeg again to update this button

                    //
                    // AppRouter.route.pushNamed(RoutePath.claimsScreen);
                    // AppDialog.show(
                    //   context: context,
                    //   title: AppStrings.offerClaimedTitle.tr,
                    //   subtitle: AppStrings.offerClaimedSuccess.tr,
                    //   type: AppDialogType.success,
                    //   showDefaultButtons: true,
                    //   confirmText: "OK",
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.claimOfferNow.tr,
                    style: context.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
