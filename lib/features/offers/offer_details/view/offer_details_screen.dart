import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/common_controller/common_controller.dart';
import '../../shared/response/offers_response.dart';
import '../controller/offer_detail_controller.dart';
import '../shimmer/offer_details_shimmer.dart';
import '../widgets/claim_offer_now_button.dart';
import '../widgets/offer_details_action_button.dart';
import '../widgets/offer_details_primary_card.dart';
import '../widgets/offer_details_terms_card.dart';

class OfferDetailsScreen extends GetView<OfferDetailController> {
  const OfferDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      title: AppStrings.offerDetails.tr,
      onPressed: () => AppRouter.route.pop(),
      // ============================================================
      // Sticky Claim Button
      // Only shown when coming from claim flow
      // ============================================================
      bottomWidget: Obx(() {
        return (controller.isFromClaim &&
                controller.offer.value?.isClaimed == false)
            ? ClaimOfferNowButton()
            : const SizedBox.shrink();
      }),
      body: Obx(
        () => ApiStatusBuilder(
          status: controller.status.value,
          errorMessage: controller.errorMessage.value,
          onRetry: controller.refreshOffer,
          loadingWidget: const OfferDetailsShimmer(),
          builder: (_) {
            final offer = controller.offer.value!;

            return Column(
              children: [
                CustomRefreshIndicator(
                  onRefresh: () async {
                    await controller.refreshOffer();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 6.h,
                    ),
                    child: Column(
                      children: [
                        // ======================================================
                        // Offer Card + Share / Bookmark
                        // ======================================================
                        Stack(
                          children: [
                            OfferDetailsPrimaryCard(offer: offer),

                            // ==================================================
                            // Share + Bookmark
                            // Only visible from claim flow
                            // ==================================================
                            if (controller.isFromClaim)
                              Positioned(
                                top: 12.h,
                                right: 12.w,
                                child: Row(
                                  children: [
                                    // Share
                                    // _buildActionButton(
                                    //   icon: Icons.share_outlined,
                                    //   onTap: () {
                                    //     // Add your share implementation here.
                                    //   },
                                    // ),

                                    // Gap(8.w),

                                    // Bookmark
                                    Obx(() {
                                      return ApiStatusBuilder(
                                        errorMessage:
                                            controller.saveErrorMessage.value,
                                        onRetry: () {},
                                        status: controller.saveStatus.value,
                                        loadingWidget: LoadingWidget(),

                                        builder: (context) => _buildActionButton(
                                          icon: controller.isOfferSaved.value
                                              ? Icons.bookmark_rounded
                                              : Icons.bookmark_border_rounded,
                                          color: controller.isOfferSaved.value
                                              ? AppColors.blueAccentColor
                                              : null,
                                          onTap: controller.toggleOfferSaved,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            if (controller.isFromClaim)
                              Positioned(
                                top: 18.h,
                                left: 12.w,
                                child: RatingBadge(offer: offer),
                              ),
                          ],
                        ),

                        Gap(16.h),

                        OfferDetailsTermsCard(offer: offer),

                        Gap(32.h),

                        // ==================================================
                        // Previous button - KEEPING IT
                        // ==================================================
                        if (CommonController.to.isMerchandiser &&
                            offer.status == "scheduled")
                          OfferDetailsActionButton(offer: offer),

                        // Extra bottom space when claim button is visible
                        if (controller.isFromClaim) Gap(80.h),

                        Gap(40.h),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  } // ============================================================
  // Share / Bookmark Button
  // ============================================================

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color? color,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: SizedBox(
          width: 40.w,
          height: 40.w,
          child: Icon(
            icon,
            color: color ?? AppColors.darkTextColor,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}

class RatingBadge extends StatelessWidget {
  final OfferModel offer;

  const RatingBadge({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: AppColors.orangeSecondaryAccentColor,
            size: 14.sp,
          ),
          Gap(4.w),
          Text(
            offer.business?.ratingAvg?.toStringAsFixed(1) ?? '0.0',
            style: context.bodySmall.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
