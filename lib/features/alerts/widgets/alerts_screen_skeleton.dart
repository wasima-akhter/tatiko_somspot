import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/share/export/screen_export.dart';

class AlertsScreenSkeleton extends StatelessWidget {
  const AlertsScreenSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (_, index) => Gap(12.h),
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: AutoShimmerAnimate(
            isLoading: true,
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),

                Gap(12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.w,
                        height: 14.h,
                        color: Colors.white,
                      ),

                      Gap(8.h),

                      Container(
                        width: double.infinity,
                        height: 12.h,
                        color: Colors.white,
                      ),

                      Gap(6.h),

                      Container(
                        width: 100.w,
                        height: 12.h,
                        color: Colors.white,
                      ),

                      Gap(8.h),

                      Container(width: 50.w, height: 10.h, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
