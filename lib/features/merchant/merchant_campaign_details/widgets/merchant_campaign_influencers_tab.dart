import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../controller/merchant_campaign_details_controller.dart';
import 'merchant_campaign_influencer_card.dart';

class MerchantCampaignInfluencersTab
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignInfluencersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.applicationsPaginator.status.value,

        errorMessage: controller.applicationsPaginator.errorMessage.value,

        onRetry: () {
          controller.refreshApplications();
        },

        isLoadingMore:
            controller.applicationsPaginator.loadMoreStatus.value ==
            ApiStatus.loading,

        hasMore: controller.applicationsPaginator.hasMore.value,

        loadingWidget: _loading(),

        builder: (context) {
          final applications = controller.applications;

          return Column(
            children: [
              _infoBanner(context),

              Gap(14.h),

              if (applications.isEmpty)
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  controller: controller.applicationScrollController,

                  itemCount: applications.length + 1,

                  itemBuilder: (_, index) {
                    if (index == applications.length) {
                      if (controller
                              .applicationsPaginator
                              .loadMoreStatus
                              .value ==
                          ApiStatus.loading) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: const Center(child: LoadingWidget()),
                        );
                      }

                      return const SizedBox();
                    }

                    final application = applications[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 14.h),

                      child: MerchantCampaignInfluencerCard(
                        application: application,
                      ),
                    );
                  },
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
