import '../../../../../share/export/screen_export.dart';

class NearbyEmptyState extends StatelessWidget {
  const NearbyEmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.icon = Icons.search_off_rounded,
  });

  final String title;
  final String message;
  final VoidCallback onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 23.sp),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(3.h),
                Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                    height: 1.3,
                  ),
                ),
                Gap(8.h),
                SizedBox(
                  height: 30.h,
                  child: TextButton.icon(
                    onPressed: onRetry,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: AppColors.primaryColor,
                    ),
                    icon: Icon(Icons.refresh_rounded, size: 14.sp),
                    label: Text(
                      AppStrings.tryAgain.tr,
                      style: context.bodySmall.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
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
