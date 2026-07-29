import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../shared/response/offers_response.dart';
import '../helper/offer_details_helper.dart';

class OfferDetailsCoverSection extends StatelessWidget {
  final OfferModel offer;

  const OfferDetailsCoverSection({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),

          child: CustomNetworkImage(
            imageUrl: offer.business?.logo ?? '',

            height: 200.h,

            width: double.infinity,

            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          bottom: 12.h,

          left: 12.w,

          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),

                decoration: BoxDecoration(
                  color: AppColors.white,

                  borderRadius: BorderRadius.circular(12.r),
                ),

                child: Row(
                  children: [
                    Container(
                      width: 6.w,

                      height: 6.w,

                      decoration: BoxDecoration(
                        color: OfferDetailsHelper.statusTextColor(offer.status),

                        shape: BoxShape.circle,
                      ),
                    ),

                    Gap(6.w),

                    Text(
                      offer.status.capitalizeFirst ?? '',

                      style: context.bodySmall.copyWith(
                        color: OfferDetailsHelper.statusTextColor(offer.status),

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Gap(8.w),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),

                decoration: BoxDecoration(
                  color: AppColors.amberYellowColor,

                  borderRadius: BorderRadius.circular(12.r),
                ),

                child: Text(
                  offer.discountLabel,

                  style: context.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,

                    color: AppColors.darkTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
