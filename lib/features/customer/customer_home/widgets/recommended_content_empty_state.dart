import '../../../../share/export/screen_export.dart';

class RecommendedContentEmptyState extends StatelessWidget {
  const RecommendedContentEmptyState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.play_circle_outline_rounded,
              size: 22.sp,
              color: AppColors.primaryColor,
            ),
          ),

          Gap(12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.noContentYet.tr,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(2.h),

                Text(
                  AppStrings.newVideosWillAppearHere.tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),

          Gap(8.w),

          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onRetry,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                AppStrings.retry.tr,
                style: context.bodySmall.copyWith(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
