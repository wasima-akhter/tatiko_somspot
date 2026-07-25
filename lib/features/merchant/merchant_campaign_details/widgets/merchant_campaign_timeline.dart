import '../../../../share/controller/screen_export.dart';
import '../controller/merchant_campaign_details_controller.dart';
import '../helper/merchant_campaign_detail_helper.dart';

class MerchantCampaignTimeline
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final timeline = controller.timeline;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          ...timeline.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;

            return Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: Row(
                children: [
                  _indicator(step, index),
                  Gap(12.w),
                  Expanded(
                    child: Text(
                      step.title,
                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: step.isPending
                            ? Colors.grey
                            : AppColors.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.shield_tick,
                  size: 15.sp,
                  color: AppColors.primaryColor,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    "SomSpot Admin assigns creators. Track their progress and review submitted content here.",
                    style: context.bodySmall.copyWith(fontSize: 10.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(MerchantCampaignTimelineStep step, int index) {
    if (step.isCompleted) {
      return CircleAvatar(
        radius: 11.r,
        backgroundColor: Colors.green,
        child: Icon(Icons.check, color: Colors.white, size: 13.sp),
      );
    }

    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: step.isCurrent
            ? AppColors.primaryColor.withValues(alpha: .12)
            : const Color(0xffF5F7FA),
      ),
      child: Center(
        child: Text(
          "${index + 1}",
          style: TextStyle(
            fontSize: 10.sp,
            color: step.isCurrent ? AppColors.primaryColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
