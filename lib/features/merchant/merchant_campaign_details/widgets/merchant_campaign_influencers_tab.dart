import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/merchant_campaign_details_controller.dart';
import 'merchant_campaign_influencer_card.dart';

class MerchantCampaignInfluencersTab
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignInfluencersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.status.value,

        errorMessage: controller.errorMessage.value,

        onRetry: () {
          controller.loadDetails(controller.campaignId);
        },

        loadingWidget: _loading(),

        builder: (context) {
          final influencers = controller.influencers ?? [];

          return Column(
            children: [
              _infoBanner(context),

              Gap(14.h),

              if (influencers.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 30.h),

                  child: Text(
                    "No creators assigned yet",
                    style: context.bodyMedium.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                )
              else
                ...influencers.map(
                  (e) => Padding(
                    padding: EdgeInsets.only(bottom: 14.h),

                    child: MerchantCampaignInfluencerCard(data: e),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _loading() {
    return Column(
      children: [
        _infoBannerSkeleton(),

        Gap(14.h),

        ...List.generate(
          3,
          (_) => Padding(
            padding: EdgeInsets.only(bottom: 14.h),

            child: AutoShimmerAnimate(
              isLoading: true,

              baseColor: AppColors.shimmerBaseColor,

              child: Container(
                height: 80.h,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoBanner(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),

      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: .08),

        borderRadius: BorderRadius.circular(10.r),

        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: .12),
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(Iconsax.shield_tick, size: 18.sp, color: AppColors.primaryColor),

          Gap(8.w),

          Expanded(
            child: Text(
              "These creators were assigned by SomSpot Admin. Assignment cannot be changed from the merchant app.",

              style: context.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBannerSkeleton() {
    return AutoShimmerAnimate(
      isLoading: true,

      baseColor: AppColors.shimmerBaseColor,

      child: Container(
        height: 55.h,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
