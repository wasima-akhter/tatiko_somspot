import '../../../share/controller/screen_export.dart';

class SubscriptionUsageCard extends StatelessWidget {
  const SubscriptionUsageCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Ekhon static — backend theke ashbe
    const int used = 3;
    const int total = 5; // Growth plan has 5 free posts
    const double progress = used / total;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.backgroundsLinesColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.amberYellowColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Iconsax.flash_1,
                  color: AppColors.amberYellowColor,
                  size: 20.sp,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hot Deal Posts This Month'.tr,
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      '$used of $total free posts used'.tr,
                      style: context.bodySmall.copyWith(
                        color: AppColors.subtitleTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(16.h),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8.h,
              backgroundColor: AppColors.softSlateBgColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 1.0 ? AppColors.error : AppColors.blueAccentColor,
              ),
            ),
          ),
          Gap(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.blueAccentColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.info_circle,
                  size: 16.sp,
                  color: AppColors.blueAccentColor,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    'Extra posts after free limit: \$5 each'.tr,
                    style: context.bodySmall.copyWith(
                      color: AppColors.blueAccentColor,
                      fontWeight: FontWeight.w500,
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
