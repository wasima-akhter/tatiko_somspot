import '../../../../helper/text_utils/string_extension.dart';
import '../../../../share/controller/screen_export.dart';
import '../../shared/response/offers_response.dart';
import 'offer_details_date_row.dart';
import 'offer_details_expiry_banner.dart';

class OfferDetailsInfoSection extends StatelessWidget {
  final OfferModel offer;

  const OfferDetailsInfoSection({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            (offer.business?.name ?? '').capitalizeWords(),

            style: context.bodyMedium.copyWith(
              color: AppColors.primaryColor,

              fontWeight: FontWeight.w600,
            ),
          ),

          Gap(8.h),

          Text(
            offer.title.capitalizeWords(),

            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.bold,

              color: AppColors.darkTextColor,
            ),
          ),

          Gap(12.h),

          Text(
            offer.description.capitalizeFirst ?? '',

            style: context.bodyMedium.copyWith(
              color: AppColors.subtitleTextColor,

              height: 1.5,
            ),
          ),

          Gap(16.h),

          OfferDetailsExpiryBanner(endDate: offer.endAt),

          Gap(16.h),

          Row(
            children: [
              Expanded(
                child: OfferDetailsDateRow(
                  title: AppStrings.starts.tr,

                  date: offer.startAt,

                  iconColor: AppColors.blueAccentColor,
                ),
              ),

              Expanded(
                child: OfferDetailsDateRow(
                  title: AppStrings.ends.tr,

                  date: offer.endAt,

                  iconColor: AppColors.orangeColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
