import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../share/controller/screen_export.dart';

class OfferDetailsPrimaryShimmer extends StatelessWidget {
  const OfferDetailsPrimaryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(16.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),

          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, -3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /// Cover image
          AutoShimmerAnimate(
            isLoading: true,
            baseColor: AppColors.shimmerBaseColor,

            child: Container(
              height: 200.h,

              width: double.infinity,

              decoration: BoxDecoration(
                color: AppColors.shimmerBaseColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.w),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                _line(width: 100.w, height: 14.h),

                Gap(10.h),

                _line(width: 220.w, height: 24.h),

                Gap(12.h),

                _line(width: double.infinity, height: 14.h),

                Gap(6.h),

                _line(width: 280.w, height: 14.h),

                Gap(18.h),

                Container(
                  height: 48.h,

                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: AppColors.shimmerBaseColor,

                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),

                Gap(18.h),

                Row(
                  children: [
                    Expanded(child: _datePlaceholder()),

                    Expanded(child: _datePlaceholder()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line({required double width, required double height}) {
    return AutoShimmerAnimate(
      isLoading: true,
      baseColor: AppColors.shimmerBaseColor,

      child: Container(
        height: height,

        width: width,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }

  Widget _datePlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        _line(width: 50.w, height: 12.h),

        Gap(8.h),

        _line(width: 120.w, height: 16.h),
      ],
    );
  }
}
