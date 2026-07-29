import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../share/controller/screen_export.dart';

class OfferDetailsTermsShimmer extends StatelessWidget {
  const OfferDetailsTermsShimmer({super.key});

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
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          _box(width: 200.w, height: 20.h),

          Gap(16.h),

          _box(width: double.infinity, height: 14.h),

          Gap(8.h),

          _box(width: 280.w, height: 14.h),
        ],
      ),
    );
  }

  Widget _box({required double width, required double height}) {
    return AutoShimmerAnimate(
      isLoading: true,
      baseColor: AppColors.shimmerBaseColor,

      child: Container(
        width: width,

        height: height,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }
}
