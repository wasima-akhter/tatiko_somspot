import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/share/controller/screen_export.dart';

class MerchantReviewsSkeleton extends StatelessWidget {
  const MerchantReviewsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                shimmerBox(width: 55.w, height: 38.h),
                Gap(12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                        3,
                        (_) => Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: shimmerBox(
                            width: 16.w,
                            height: 16.w,
                            borderRadius: 4.r,
                          ),
                        ),
                      ),
                    ),
                    Gap(6.h),
                    shimmerBox(width: 100.w, height: 12.h),
                  ],
                ),
                const Spacer(),
                shimmerBox(width: 100.w, height: 36.h, borderRadius: 20.r),
              ],
            ),
          ),

          Gap(12.h),

          ...List.generate(
            1,
            (_) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: buildReviewSkeleton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReviewSkeleton() {
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
              shimmerBox(width: 40.w, height: 40.w, borderRadius: 20.r),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    shimmerBox(width: 110.w, height: 14.h),
                    Gap(6.h),
                    shimmerBox(width: 65.w, height: 10.h),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  1,
                  (_) => Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: shimmerBox(
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

          shimmerBox(width: double.infinity, height: 14.h),
          Gap(7.h),
          shimmerBox(width: 280.w, height: 14.h),
          Gap(7.h),
          shimmerBox(width: 200.w, height: 14.h),

          Gap(14.h),

          shimmerBox(width: 95.w, height: 30.h, borderRadius: 12.r),
        ],
      ),
    );
  }

  Widget shimmerBox({
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
