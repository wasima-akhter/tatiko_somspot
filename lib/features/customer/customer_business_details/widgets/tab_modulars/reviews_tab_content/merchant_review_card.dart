import 'package:som_spot/share/export/screen_export.dart';

import '../../../../review/response/review_response.dart';
import 'merchant_review_stars.dart';

class MerchantReviewCard extends StatelessWidget {
  const MerchantReviewCard({super.key, required this.review});

  final BusinessReviewModel review;

  @override
  Widget build(BuildContext context) {
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
                backgroundColor: AppColors.backgroundColor,
                backgroundImage: review.user.profileImage.isNotEmpty
                    ? NetworkImage(review.user.profileImage)
                    : null,
                child: review.user.profileImage.isEmpty
                    ? Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.subtitleTextColor,
                        size: 22.sp,
                      )
                    : null,
              ),

              Gap(12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user.name.isNotEmpty
                          ? review.user.name
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
              review.review,
              style: context.bodyMedium.copyWith(
                color: AppColors.darkTextColor,
                height: 1.4,
              ),
            ),

          Gap(12.h),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.thumb_up_alt_outlined,
                size: 14.sp,
                color: AppColors.subtitleTextColor,
              ),
              Gap(6.w),
              Text(
                "${AppStrings.helpful.tr} (${review.helpfulCount})",
                style: context.bodySmall.copyWith(
                  color: AppColors.subtitleTextColor,
                ),
              ),
            ],
          ),
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
