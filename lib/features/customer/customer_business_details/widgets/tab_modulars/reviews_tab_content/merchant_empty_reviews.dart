import 'package:som_spot/share/export/screen_export.dart';

class MerchantEmptyReviews extends StatelessWidget {
  const MerchantEmptyReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 48.sp,
            color: AppColors.subtitleTextColor,
          ),
          Gap(12.h),
          Text(
            AppStrings.noReviewsYet.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(4.h),
          Text(
            AppStrings.beTheFirstToReview.tr,
            textAlign: TextAlign.center,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
