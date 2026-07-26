import '../../../share/controller/screen_export.dart';

class SubscriptionStepItem extends StatelessWidget {
  final String step;
  final String title;
  final String desc;
  final bool isLast;

  const SubscriptionStepItem({
    super.key,
    required this.step,
    required this.title,
    required this.desc,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: AppColors.blueAccentColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: context.bodySmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30.h,
                color: AppColors.blueAccentColor.withValues(alpha: 0.2),
              ),
          ],
        ),
        Gap(14.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTextColor,
                  ),
                ),
                Gap(2.h),
                Text(
                  desc,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
