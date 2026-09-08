import 'package:som_spot/features/customer/customer_business_details/controller/customer_business_details_controller.dart';
import 'package:som_spot/features/customer/customer_offer_claim/helper/customer_offer_claim_helper.dart';
import 'package:som_spot/features/offers/offer_details/controller/offer_detail_controller.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../share/export/screen_export.dart';

class ClaimOfferNowButton extends StatelessWidget {
  const ClaimOfferNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OfferDetailController.to;

    return Obx(() {
      final offer = controller.offer.value;

      // Hide button when:
      // - offer is not loaded
      // - offer has already been claimed
      if (offer == null || offer.isClaimed == true) {
        return const SizedBox.shrink();
      }

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
        child: SizedBox(
          width: double.infinity,
          height: 52.h,
          child: controller.claimStatus.value == ApiStatus.loading
              ? const LoadingWidget()
              : ElevatedButton(
                  onPressed: () async {
                    final claim = await controller.claimOffer();

                    if (claim == null) {
                      debugPrint('parsed claim is null');
                      return;
                    }

                    debugPrint('========== CLAIM BODY ==========');
                    debugPrint('id: ${claim.id}');
                    debugPrint('user: ${claim.user}');
                    debugPrint('offer: ${claim.offer}');
                    debugPrint('business: ${claim.business}');
                    debugPrint('code: ${claim.code}');
                    debugPrint('status: ${claim.status}');
                    debugPrint('claimedAt: ${claim.claimedAt}');
                    debugPrint('expiresAt: ${claim.expiresAt}');
                    debugPrint('================================');

                    controller.offer.update((offer) {
                      if (offer != null) offer.isClaimed = true;

                      debugPrint('offer is null');
                    });

                    AppRouter.route.pushNamed(
                      RoutePath.offerClaimScreen,
                      extra: OfferClaimArgs(claimCode: claim.code),
                    );

                    if (Get.isRegistered<CustomerBusinessDetailsController>()) {
                      CustomerBusinessDetailsController.to.refreshOffers();
                    }
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
        ),
      );
    });
  }
}
