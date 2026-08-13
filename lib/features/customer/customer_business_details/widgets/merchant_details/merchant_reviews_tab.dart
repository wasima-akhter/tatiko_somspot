import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/dialog/custom_dialog.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../review/response/review_response.dart';
import '../../controller/customer_business_details_controller.dart';

class MerchantReviewsTab extends StatefulWidget {
  const MerchantReviewsTab({super.key});

  @override
  State<MerchantReviewsTab> createState() => _MerchantReviewsTabState();
}

class _MerchantReviewsTabState extends State<MerchantReviewsTab> {
  final controller = CustomerBusinessDetailsController.to;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.reviewsPaginator.status.value,
        errorMessage: controller.reviewsPaginator.errorMessage.value,
        onRetry: controller.refreshBusinessReviews,
        loadingWidget: const _MerchantReviewsSkeleton(),

        isLoadingMore:
            controller.reviewsPaginator.loadMoreStatus.value ==
            ApiStatus.loading,

        hasMore: controller.reviewsPaginator.hasMore.value,

        builder: (_) {
          final reviews = controller.reviews;

          debugPrint('reviews length: ${reviews.length}');

          return CustomRefreshIndicator(
            onRefresh: controller.refreshBusinessReviews,
            child: SingleChildScrollView(
              controller: controller.reviewListScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 64.h),
              child: Container(
                color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRatingSummary(context, controller: controller),

                    Gap(12.h),

                    if (reviews.isEmpty)
                      _buildEmptyReviews(context)
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: reviews.length,
                        separatorBuilder: (_, index) => Gap(16.h),
                        itemBuilder: (context, index) {
                          return _buildReviewCard(
                            context,
                            review: reviews[index],
                          );
                        },
                      ),

                    // Load more
                    Obx(() {
                      final loading =
                          controller.reviewsPaginator.loadMoreStatus.value ==
                          ApiStatus.loading;

                      if (!loading) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      );
                    }),

                    Gap(64.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // Rating Summary
  // ============================================================

  Widget _buildRatingSummary(
    BuildContext context, {
    required CustomerBusinessDetailsController controller,
  }) {
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
                      _buildStars(rating, size: 16.sp),
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
              _showWriteReviewDialog(context, controller);
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

  // ============================================================
  // Review Card
  // ============================================================

  Widget _buildReviewCard(
    BuildContext context, {
    required BusinessReviewModel review,
  }) {
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
                          : 'Anonymous',
                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      _formatDate(review.createdAt),
                      style: context.bodySmall.copyWith(
                        color: AppColors.subtitleTextColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),

              _buildStars(review.rating, size: 14.sp),
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

  // ============================================================
  // Stars
  // ============================================================

  Widget _buildStars(double rating, {required double size}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starNumber = index + 1;

        IconData icon;

        if (rating >= starNumber) {
          icon = Icons.star_rounded;
        } else if (rating >= starNumber - 0.5) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_border_rounded;
        }

        return Icon(
          icon,
          color: AppColors.orangeSecondaryAccentColor,
          size: size,
        );
      }),
    );
  }

  // ============================================================
  // Empty State
  // ============================================================

  Widget _buildEmptyReviews(BuildContext context) {
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
            "No reviews yet",
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(4.h),
          Text(
            "Be the first to review this business.",
            textAlign: TextAlign.center,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Write Review Dialog
  // ============================================================

  void _showWriteReviewDialog(
    BuildContext context,
    CustomerBusinessDetailsController controller,
  ) {
    final contentController = TextEditingController();
    double currentRating = 5.0;

    AppDialog.show(
      context: context,
      type: AppDialogType.custom,
      title: AppStrings.writeAReview.tr,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      borderRadius: 16.r,
      maxWidth: 500.w,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starVal = index + 1.0;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentRating = starVal;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Icon(
                        Icons.star,
                        color: starVal <= currentRating
                            ? AppColors.orangeSecondaryAccentColor
                            : AppColors.backgroundsLinesColor,
                        size: 32.sp,
                      ),
                    ),
                  );
                }),
              ),

              Gap(20.h),

              TextField(
                controller: contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: AppStrings.tellUsExperience.tr,
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(16.r),
                ),
              ),

              Gap(24.h),

              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () async {
                    final content = contentController.text.trim();

                    if (content.isEmpty) {
                      AppToast.error(
                        context: context,
                        message: AppStrings.enterReviewContent.tr,
                      );
                      return;
                    }

                    final success = await controller.postReview(
                      rating: currentRating,
                      review: content,
                    );

                    if (!context.mounted) return;

                    Navigator.of(context).pop();

                    if (success) {
                      AppToast.success(
                        context: context,
                        message: AppStrings.reviewAdded.tr,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Obx(
                    () => controller.postReviewStatus.value == ApiStatus.loading
                        ? const LoadingWidget()
                        : Text(
                            AppStrings.submitReview.tr,
                            style: context.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ============================================================
  // Date
  // ============================================================

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }

    return '${date.day}/${date.month}/${date.year}';
  }
}

// ================================================================
// Skeleton
// ================================================================

class _MerchantReviewsSkeleton extends StatelessWidget {
  const _MerchantReviewsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                _shimmerBox(width: 55.w, height: 38.h),
                Gap(12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (_) => Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: _shimmerBox(
                            width: 16.w,
                            height: 16.w,
                            borderRadius: 4.r,
                          ),
                        ),
                      ),
                    ),
                    Gap(6.h),
                    _shimmerBox(width: 100.w, height: 12.h),
                  ],
                ),
                const Spacer(),
                _shimmerBox(width: 100.w, height: 36.h, borderRadius: 20.r),
              ],
            ),
          ),

          Gap(12.h),

          ...List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: _buildReviewSkeleton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSkeleton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _shimmerBox(width: 40.w, height: 40.w, borderRadius: 20.r),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(width: 110.w, height: 14.h),
                    Gap(6.h),
                    _shimmerBox(width: 65.w, height: 10.h),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (_) => Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: _shimmerBox(
                      width: 14.w,
                      height: 14.w,
                      borderRadius: 4.r,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Gap(14.h),

          _shimmerBox(width: double.infinity, height: 14.h),
          Gap(7.h),
          _shimmerBox(width: 280.w, height: 14.h),
          Gap(7.h),
          _shimmerBox(width: 200.w, height: 14.h),

          Gap(14.h),

          _shimmerBox(width: 95.w, height: 30.h, borderRadius: 12.r),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double? borderRadius,
  }) {
    return AutoShimmerAnimate(
      isLoading: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
        ),
      ),
    );
  }
}
