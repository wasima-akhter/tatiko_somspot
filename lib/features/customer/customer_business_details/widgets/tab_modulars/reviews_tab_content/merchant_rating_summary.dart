import 'package:som_spot/share/controller/screen_export.dart';

import '../../../controller/customer_business_details_controller.dart';
import 'merchant_review_stars.dart';
import 'merchant_write_review_dialog.dart';

class MerchantRatingSummary extends StatelessWidget {
  MerchantRatingSummary({super.key});

  final controller = CustomerBusinessDetailsController.to;

  @override
  Widget build(BuildContext context) {
    final business = controller.business.value;

    final rating = business?.ratingAvg ?? 0.0;
    final ratingCount = business?.ratingCount ?? 0;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    rating.toStringAsFixed(1),
                    style: context.headlineLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  Gap(8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MerchantReviewStars(rating: rating, size: 16.sp),
                      Gap(4.h),
                      Text(
                        "$ratingCount ${AppStrings.reviewsLabel.tr}",
                        style: context.bodySmall.copyWith(
                          color: AppColors.subtitleTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              MerchantWriteReviewDialog.show(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              side: const BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            ),
            child: Text(
              AppStrings.writeReview.tr,
              style: context.bodySmall.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
