import '../../../../share/controller/screen_export.dart';

class CampaignCardNavigator extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CampaignCardNavigator({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: AppColors.deepBlueColor,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Iconsax.award,
                    color: const Color(0xFFFFC107),
                    size: 20.sp,
                  ),
                ),
              ),

              Gap(14.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: .9),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),

              Gap(8.w),

              Icon(Icons.chevron_right, color: Colors.white, size: 22.sp),
            ],
          ),
        ),
      ),
    );
  }
}
