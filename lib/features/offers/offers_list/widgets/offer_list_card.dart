import 'package:som_spot/features/offers/offer_details/helper/offer_details_arg_model.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../offer_details/controller/offer_detail_controller.dart';
import '../../shared/helper/offer_helper.dart';
import '../../shared/response/offers_response.dart';

class OfferListCard extends StatelessWidget {
  final OfferModel offer;
  final String offerId;
  final String badgeText;
  final String imagePath;
  final String restaurantName;
  final String title;
  final String timeText;
  final bool isEndingSoon;
  final String actionText;
  final OfferActionType actionType;
  const OfferListCard({
    super.key,
    required this.badgeText,
    required this.imagePath,
    required this.restaurantName,
    required this.title,
    required this.timeText,
    required this.isEndingSoon,
    required this.actionText,
    required this.actionType,
    required this.offerId,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (Get.isRegistered<OfferDetailController>()) {
          Get.delete<OfferDetailController>();
        }
        AppRouter.route.pushNamed(
          RoutePath.offerDetailsScreen,
          extra: OfferDetailsArgs(offerId: offerId),
        );
      },
      child: Container(
        height: 120.h,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Image Section ──
            ClipRRect(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16.r),
              ),
              child: Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: imagePath,
                    width: 100.w,
                    height: 120.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.amberYellowColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        badgeText,
                        style: context.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Details Section ──
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurantName.capitalizeWords(),
                          style: context.bodySmall.copyWith(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(4.h),
                        Text(
                          title.capitalizeWords(),
                          style: context.bodyMedium.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: isEndingSoon
                                ? AppColors.orangeColor.withValues(alpha: 0.1)
                                : AppColors.orangeColor.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: isEndingSoon
                                    ? AppColors.orangeColor
                                    : AppColors.orangeColor, // same for now
                                size: 14.sp,
                              ),
                              Gap(4.w),
                              Text(
                                timeText,
                                style: context.bodySmall.copyWith(
                                  color: AppColors.orangeColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(4.w),
                        Expanded(child: _buildAction()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction() {
    switch (actionType) {
      case OfferActionType.claims:
        return Text(
          actionText,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.emeraldGreenColor,
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
          ),
        );

      case OfferActionType.claimed:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.emeraldGreenColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            actionText,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.emeraldGreenColor,
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
          ),
        );

      case OfferActionType.edit:
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AppRouter.route.pushNamed(RoutePath.editOfferScreen, extra: offer);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.blueAccentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              actionText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.blueAccentColor,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ),
        );
    }
  }

  //
}
