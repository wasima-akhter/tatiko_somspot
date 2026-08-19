import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../../share/export/screen_export.dart';

class RecommendedContentShimmer extends StatelessWidget {
  const RecommendedContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSkeleton(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: _buildTextSkeleton(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSkeleton() {
    return SizedBox(
      height: 155.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image placeholder
          Container(color: AppColors.grayTabBgColor),

          // Platform badge
          Positioned(
            top: 10.h,
            left: 10.w,
            child: _shimmerBox(width: 72.w, height: 25.h, radius: 20.r),
          ),

          // Creator
          Positioned(
            bottom: 10.h,
            left: 10.w,
            child: Row(
              children: [
                _shimmerCircle(24.w),

                Gap(5.w),

                _shimmerBox(width: 65.w, height: 10.h, radius: 5.r),
              ],
            ),
          ),

          // Views badge
          Positioned(
            top: 10.h,
            right: 10.w,
            child: _shimmerBox(width: 48.w, height: 25.h, radius: 20.r),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shimmerBox(width: double.infinity, height: 12.h, radius: 4.r),

        Gap(7.h),

        _shimmerBox(width: 75.w, height: 12.h, radius: 4.r),
      ],
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    required double radius,
  }) {
    return AutoShimmerAnimate(
      isLoading: true,
      baseColor: AppColors.grayTabBgColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  Widget _shimmerCircle(double size) {
    return AutoShimmerAnimate(
      isLoading: true,
      baseColor: AppColors.grayTabBgColor,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
