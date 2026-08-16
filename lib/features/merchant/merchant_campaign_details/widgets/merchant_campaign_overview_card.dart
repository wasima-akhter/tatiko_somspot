import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/merchant_campaign_details_controller.dart';

class MerchantCampaignOverviewCard
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignOverviewCard({super.key});

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
          final campaign = controller.campaign.value;

          if (campaign == null) {
            return const SizedBox();
          }

          return _card(
            context,

            budget: "\$${campaign.totalBudget}",

            creators: "${campaign.assignedCount}/${campaign.targetCreators}",

            package: campaign.contentType,

            duration: AppStrings.daysLeft.trParams({
              'count': campaign.daysLeft.toString(),
            }),
            //  "${campaign.daysLeft} ${AppStrings.daysLeft.tr}",
          );
        },
      ),
    );
  }

  Widget _card(
    BuildContext context, {

    required String budget,
    required String creators,
    required String package,
    required String duration,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(14.r),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _item(AppStrings.budget.tr, budget)),

              Expanded(child: _item(AppStrings.influencers.tr, creators)),
            ],
          ),

          Gap(16.h),

          Row(
            children: [
              Expanded(child: _item(AppStrings.package.tr, package)),

              Expanded(child: _item(AppStrings.duration.tr, duration)),
            ],
          ),
        ],
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
        children: [
          Row(
            children: [
              Expanded(child: _loadingItem()),

              Expanded(child: _loadingItem()),
            ],
          ),

          Gap(16.h),

          Row(
            children: [
              Expanded(child: _loadingItem()),

              Expanded(child: _loadingItem()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _loadingItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          "--",
          style: TextStyle(fontSize: 11.sp, color: Colors.transparent),
        ),

        Gap(3.h),

        AutoShimmerAnimate(
          isLoading: true,

          baseColor: AppColors.shimmerBaseColor,

          child: Container(
            width: 70.w,
            height: 15.h,

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
      ],
    );
  }

  Widget _item(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: TextStyle(fontSize: 11.sp, color: AppColors.subtitleTextColor),
        ),

        Gap(3.h),

        Text(
          value,

          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
