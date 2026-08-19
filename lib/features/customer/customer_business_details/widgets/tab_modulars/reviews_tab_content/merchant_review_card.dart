import 'package:som_spot/features/customer/customer_business_details/controller/customer_business_details_controller.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../review/response/review_response.dart';
import 'merchant_review_stars.dart';

class MerchantReviewCard extends StatelessWidget {
  const MerchantReviewCard({super.key, required this.review});

  final BusinessReviewModel review;

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,

                child: CustomNetworkImage(
                  imageUrl: review.user.profileImage,
                  boxShape: BoxShape.circle,
                ),
              ),

              Gap(12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user.name.isNotEmpty
                          ? review.user.name.capitalizeWords()
                          : AppStrings.anonymous.tr,
                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      MerchantReviewCard.formatDate(review.createdAt),
                      style: context.bodySmall.copyWith(
                        color: AppColors.subtitleTextColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),

              MerchantReviewStars(rating: review.rating, size: 14.sp),
            ],
          ),

          Gap(12.h),

          if (review.review.isNotEmpty)
            Text(
              review.review.capitalizeFirst ?? '',
              style: context.bodySmall.copyWith(
                color: AppColors.darkTextColor,
                fontSize: 12.sp,
                height: 1.4,
              ),
            ),

          Gap(12.h),

          // Helpful section
          Obx(() {
            final currentReview = controller.getReviewById(review.id);

            // Review may temporarily not exist during refresh.
            if (currentReview == null) {
              return const SizedBox.shrink();
            }

            final isHelpful = currentReview.isHelpful == true;
            final isLoading = controller.isHelpfulLoading(currentReview.id);

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: isLoading
                  ? null
                  : () {
                      controller.toggleReviewHelpful(
                        reviewId: currentReview.id,
                      );
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isLoading)
                    SizedBox(
                      width: 14.sp,
                      height: 14.sp,
                      child: const CircularProgressIndicator(strokeWidth: 1.5),
                    )
                  else
                    Icon(
                      isHelpful
                          ? Icons.thumb_up_alt
                          : Icons.thumb_up_alt_outlined,
                      size: 14.sp,
                      color: isHelpful
                          ? AppColors.primaryColor
                          : AppColors.subtitleTextColor,
                    ),

                  Gap(6.w),

                  Text(
                    "${AppStrings.helpful.tr} (${currentReview.helpfulCount})",
                    style: context.bodySmall.copyWith(
                      color: isHelpful
                          ? AppColors.primaryColor
                          : AppColors.subtitleTextColor,
                      fontWeight: isHelpful
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  static String formatDate(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return AppStrings.justNow.tr;
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ${AppStrings.ago.tr}';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours}h ${AppStrings.ago.tr}';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays}d ${AppStrings.ago.tr}';
    }

    return '${date.day}/${date.month}/${date.year}';
  }
}
