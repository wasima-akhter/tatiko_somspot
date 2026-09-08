// -----------------------------------------------------------------------------
// 5. Saved Offers List Widget
// -----------------------------------------------------------------------------
import 'package:som_spot/features/customer/saved/controller/saved_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../offers/offer_details/controller/offer_detail_controller.dart';
import '../../../offers/offer_details/helper/offer_details_arg_model.dart';
import '../shared/response/saved_offer_model.dart';

class SavedOffersListWidget extends GetView<SavedScreenController> {
  const SavedOffersListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.offerPaginator.status.value,
        errorMessage: controller.offerPaginator.errorMessage.value,
        onRetry: controller.loadOffers,
        isLoadingMore:
            controller.offerPaginator.loadMoreStatus.value == ApiStatus.loading,
        hasMore: controller.offerPaginator.hasMore.value,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: List.generate(controller.offerPaginator.items.length, (
                index,
              ) {
                final saved = controller.offerPaginator.items[index];
                final offer = saved.offer;

                if (offer == null) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == controller.offerPaginator.items.length - 1
                        ? 0
                        : 12.h,
                  ),
                  child: SavedOfferInfoCard(offer: offer),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

class SavedOfferInfoCard extends StatelessWidget {
  final SavedOfferInfo offer;
  const SavedOfferInfoCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Get.isRegistered<OfferDetailController>()) {
          Get.delete<OfferDetailController>();
        }

        AppRouter.route.pushNamed(
          RoutePath.offerDetailsScreen,
          extra: OfferDetailsArgs(offerId: offer.id),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CustomNetworkImage(
                    imageUrl: offer.offerImage,
                    height: 90.h,
                    width: 90.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 6.h,
                  left: 6.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.orangeSecondaryAccentColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 3.h,
                    ),
                    child: Text(
                      offer.discountLabel,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.business?.name ?? '',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    offer.title,
                    style: context.titleMedium.copyWith(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (offer.endAt != null)
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.warning.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.clock,
                                color: AppColors.warning,
                                size: 12.sp,
                              ),
                              Gap(4.w),
                              Text(
                                _getTimeLeft(offer.endAt!),
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeLeft(DateTime endAt) {
    final difference = endAt.difference(DateTime.now());

    if (difference.isNegative) {
      return AppStrings.expired.tr;
    }

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    }

    if (difference.inHours > 0) {
      return '${difference.inHours}h';
    }

    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    }

    return '<1m';
  }
}
