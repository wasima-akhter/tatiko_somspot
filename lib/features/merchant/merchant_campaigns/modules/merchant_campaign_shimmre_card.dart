import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../share/export/screen_export.dart';

class MerchantCampaignShimmerCard extends StatelessWidget {
  const MerchantCampaignShimmerCard({super.key});

  Widget _box({double? width, double height = 12, double radius = 6}) {
    return AutoShimmerAnimate(
      isLoading: true,
      child: Container(
        width: width,
        height: height.h,
        decoration: BoxDecoration(
          color: AppColors.backgroundsLinesColor,
          borderRadius: BorderRadius.circular(radius.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .04), blurRadius: 10),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title + status
          Row(
            children: [
              Expanded(child: _box(width: 150.w, height: 16)),

              SizedBox(width: 10.w),

              _box(width: 70.w, height: 12, radius: 8),
            ],
          ),

          Gap(8.h),

          // campaign type
          _box(width: 100.w, height: 12),

          Gap(18.h),

          // budget row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _box(width: 80.w, height: 12),

              _box(width: 60.w, height: 12),
            ],
          ),

          Gap(10.h),

          // progress bar
          Container(
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundsLinesColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),

          Gap(14.h),

          // bottom stats
          Row(
            children: [
              _box(width: 50.w, height: 12),

              Gap(20.w),

              _box(width: 70.w, height: 12),
            ],
          ),
        ],
      ),
    );
  }
}
