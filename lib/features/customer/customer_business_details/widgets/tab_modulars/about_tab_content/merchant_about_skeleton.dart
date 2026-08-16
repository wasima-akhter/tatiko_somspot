import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/share/export/screen_export.dart';
// ============================================================
// About Tab Loading Skeleton
// ============================================================

class MerchantAboutSkeleton extends StatelessWidget {
  const MerchantAboutSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================================
          // Description Skeleton
          // ==========================================================
          _shimmerBox(width: double.infinity, height: 16.h),

          Gap(8.h),

          _shimmerBox(width: 280.w, height: 16.h),

          Gap(8.h),

          _shimmerBox(width: 220.w, height: 16.h),

          Gap(20.h),

          // ==========================================================
          // Details Card Skeleton
          // ==========================================================
          Container(
            width: double.infinity,
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
              children: [
                _buildSkeletonInfoRow(),

                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),

                _buildSkeletonInfoRow(titleWidth: 90.w, subtitleWidth: 130.w),

                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),

                _buildSkeletonInfoRow(titleWidth: 160.w, showSubtitle: false),

                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),

                _buildSkeletonInfoRow(titleWidth: 150.w, showSubtitle: false),
              ],
            ),
          ),

          Gap(24.h),

          // ==========================================================
          // Gallery Title
          // ==========================================================
          _shimmerBox(width: 80.w, height: 20.h),

          Gap(12.h),

          // ==========================================================
          // Gallery Images
          // ==========================================================
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, index) => Gap(12.w),
              itemBuilder: (_, index) {
                return _shimmerBox(
                  width: 100.w,
                  height: 100.h,
                  borderRadius: 12.r,
                );
              },
            ),
          ),

          Gap(24.h),

          // ==========================================================
          // Rating Skeleton
          // ==========================================================
          Row(
            children: [
              _shimmerBox(width: 22.w, height: 22.w, borderRadius: 6.r),
              Gap(6.w),
              _shimmerBox(width: 35.w, height: 16.h),
              Gap(6.w),
              _shimmerBox(width: 90.w, height: 14.h),
            ],
          ),

          Gap(24.h),
        ],
      ),
    );
  }

  // ============================================================
  // Skeleton Info Row
  // ============================================================

  Widget _buildSkeletonInfoRow({
    double? titleWidth,
    double? subtitleWidth,
    bool showSubtitle = true,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoShimmerAnimate(
          isLoading: true,
          child: Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
        ),

        Gap(12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(width: titleWidth ?? 200.w, height: 16.h),

              if (showSubtitle) ...[
                Gap(6.h),
                _shimmerBox(width: subtitleWidth ?? 130.w, height: 13.h),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Generic Shimmer Box
  // ============================================================

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

class MerchantAboutSkeletonInfoRow extends StatelessWidget {
  final double? titleWidth;
  final double? subtitleWidth;
  final bool showSubtitle;

  const MerchantAboutSkeletonInfoRow({
    super.key,
    this.titleWidth,
    this.subtitleWidth,
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MerchantAboutShimmerBox(width: 20.w, height: 20.w, borderRadius: 10.r),

        Gap(12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MerchantAboutShimmerBox(
                width: titleWidth?.w ?? 200.w,
                height: 16.h,
              ),

              if (showSubtitle) ...[
                Gap(6.h),
                MerchantAboutShimmerBox(
                  width: subtitleWidth?.w ?? 130.w,
                  height: 13.h,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class MerchantAboutShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const MerchantAboutShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return AutoShimmerAnimate(
      isLoading: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
