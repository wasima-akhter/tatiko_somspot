import '../../../../share/controller/screen_export.dart';
import '../../shared/response/offers_response.dart';

class OfferDetailsTermsCard extends StatelessWidget {
  final OfferModel offer;

  const OfferDetailsTermsCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(16.w),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(12.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            AppStrings.termsAndConditions.tr,

            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,

              color: AppColors.darkTextColor,
            ),
          ),

          Gap(12.h),

          Text(
            offer.terms.capitalizeFirst ?? '',

            style: context.bodyMedium.copyWith(
              color: AppColors.subtitleTextColor,

              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
