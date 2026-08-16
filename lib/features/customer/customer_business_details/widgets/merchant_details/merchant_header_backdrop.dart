import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';

import '../../controller/customer_business_details_controller.dart';
import '../../shared/model/customer_buiness_details_model.dart';

class MerchantHeaderBackdrop
    extends GetView<CustomerBusinessDetailsController> {
  const MerchantHeaderBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.businessStatus.value,
        errorMessage: controller.businessErrorMessage.value,
        onRetry: controller.refreshBusinessDetails,

        loadingWidget: const _MerchantHeaderBackdropShimmer(),

        builder: (_) {
          final business = controller.business.value!;

          return _buildHeader(context, business: business);
        },
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required BusinessDetailsModel business,
  }) {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ============================================================
          // Cover Image
          // ============================================================
          CustomNetworkImage(imageUrl: business.coverImage, fit: BoxFit.cover),

          // ============================================================
          // Gradient Overlay
          // ============================================================
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),

          // ============================================================
          // Business Information
          // ============================================================
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // ======================================================
                    // Category Badge
                    // ======================================================
                    if (business.category != null &&
                        business.category!.name.trim().isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          business.category!.name.trim(),
                          style: context.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    if (business.category != null &&
                        business.category!.name.trim().isNotEmpty)
                      Gap(8.w),
                    // ======================================================
                    // Rating Badge
                    // ======================================================
                    if (business.ratingCount > 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.orangeSecondaryAccentColor,
                              size: 14.sp,
                            ),
                            Gap(4.w),
                            Text(
                              '${business.ratingAvg.toStringAsFixed(1)} '
                              '(${business.ratingCount})',
                              style: context.bodySmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                Gap(8.h),

                // ==========================================================
                // Business Name
                // ==========================================================
                Text(
                  business.name.trim(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Header Shimmer
// ============================================================================

class _MerchantHeaderBackdropShimmer extends StatelessWidget {
  const _MerchantHeaderBackdropShimmer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ============================================================
          // Background
          // ============================================================
          AutoShimmerAnimate(
            isLoading: true,
            child: Container(color: Colors.grey.shade300),
          ),

          // ============================================================
          // Dark Overlay
          // ============================================================
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.05),
                  Colors.black.withValues(alpha: 0.05),
                  Colors.black.withValues(alpha: 0.35),
                ],
              ),
            ),
          ),

          // ============================================================
          // Fake Business Information
          // ============================================================
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category + Rating
                Row(
                  children: [
                    AutoShimmerAnimate(
                      isLoading: true,
                      child: Container(
                        width: 75.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ),

                    Gap(8.w),

                    AutoShimmerAnimate(
                      isLoading: true,
                      child: Container(
                        width: 70.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ),
                  ],
                ),

                Gap(10.h),

                // Business name - first line
                AutoShimmerAnimate(
                  isLoading: true,
                  child: Container(
                    width: 210.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                ),

                Gap(6.h),

                // Business name - second line
                AutoShimmerAnimate(
                  isLoading: true,
                  child: Container(
                    width: 140.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
