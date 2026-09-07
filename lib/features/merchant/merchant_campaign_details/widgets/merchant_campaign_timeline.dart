import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_detail_model.dart';
import '../controller/merchant_campaign_details_controller.dart';
import '../helper/merchant_campaign_detail_helper.dart';

class MerchantCampaignTimeline
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.status.value,

        errorMessage: controller.errorMessage.value,

        onRetry: () {
          controller.loadDetails(controller.campaignId);
        },

        loadingWidget: _loadingCard(),

        builder: (context) {
          final timeline = controller.campaign.value?.timeline ?? [];

          if (timeline.isEmpty) {
            return const SizedBox();
          }

          for (var i = 0; i < timeline.length; i++) {
            debugPrint(
              'timeline stage- ${timeline[i].stage}:  ${timeline[i].done}',
            );
          }
          return _timelineCard(context, timeline);
        },
      ),
    );
  }

  TimelineStepStatus _getTimelineStatus(
    MerchantCampaignTimelineStepModel step,
  ) {
    if (step.done) {
      return TimelineStepStatus.completed;
    }

    if (step.current) {
      return TimelineStepStatus.current;
    }

    return TimelineStepStatus.pending;
  }

  Widget _timelineCard(
    BuildContext context,
    List<MerchantCampaignTimelineStepModel> timeline,
  ) {
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
                      _stageTitle(step.stage),

                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,

                        color: !step.done && !step.current
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
                    AppStrings.adminAssignsCreatorsDescription.tr,

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

  Widget _indicator(MerchantCampaignTimelineStepModel step, int index) {
    if (step.done) {
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

        color: step.current
            ? AppColors.primaryColor.withValues(alpha: .12)
            : const Color(0xffF5F7FA),
      ),

      child: Center(
        child: Text(
          "${index + 1}",

          style: TextStyle(
            fontSize: 10.sp,

            color: step.current ? AppColors.primaryColor : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _loadingCard() {
    return Container(
      padding: EdgeInsets.all(12.w),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14.r),
      ),

      child: Column(
        children: List.generate(5, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 14.h),

            child: Row(
              children: [
                AutoShimmerAnimate(
                  isLoading: true,

                  baseColor: AppColors.shimmerBaseColor,

                  child: Container(
                    width: 22.w,

                    height: 22.w,

                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,

                      color: Colors.white,
                    ),
                  ),
                ),

                Gap(12.w),

                AutoShimmerAnimate(
                  isLoading: true,

                  baseColor: AppColors.shimmerBaseColor,

                  child: Container(
                    width: 150.w,

                    height: 14.h,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String _stageTitle(String stage) {
    switch (stage) {
      case "submitted":
        return AppStrings.campaignSubmitted.tr;

      case "admin_approval":
        return AppStrings.adminApproval.tr;

      case "influencers_assigned":
        return AppStrings.influencersAssigned.tr;

      case "content_review":
        return AppStrings.contentReview.tr;

      case "published":
        return AppStrings.published.tr;

      default:
        return stage;
    }
  }
}
