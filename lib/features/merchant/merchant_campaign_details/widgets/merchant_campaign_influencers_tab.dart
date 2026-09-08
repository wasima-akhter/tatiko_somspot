import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/ui_status_builder/error_card.dart';

import '../../../../share/export/screen_export.dart';
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
        noDataWidget: _noInfluencersPlaceholder(context),

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
                    AppStrings.noInfluencersAssignedYet.tr,
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
              AppStrings.influencersAssignedByAdmin.tr,
              style: context.bodyMedium,
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

  Widget _noInfluencersPlaceholder(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76.w,
                height: 76.w,
                decoration: BoxDecoration(
                  color: AppColors.blueAccentColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.groups_rounded,
                  size: 38.sp,
                  color: AppColors.blueAccentColor,
                ),
              ),

              SizedBox(height: 18.h),

              Text(
                AppStrings.noInfluencersYet.tr,
                textAlign: TextAlign.center,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 7.h),

              Text(
                AppStrings.noInfluencersAssignedDescription.tr,
                textAlign: TextAlign.center,
                style: context.bodyMedium.copyWith(
                  color: AppColors.subtitleTextColor,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 18.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                decoration: BoxDecoration(
                  color: AppColors.blueAccentColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.blueAccentColor.withValues(alpha: 0.10),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: AppColors.blueAccentColor.withValues(
                          alpha: 0.10,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.info_outline_rounded,
                        size: 17.sp,
                        color: AppColors.blueAccentColor,
                      ),
                    ),

                    SizedBox(width: 10.w),

                    Expanded(
                      child: Text(
                        AppStrings.adminAssignsInfluencersDescription.tr,
                        style: context.bodyMedium.copyWith(
                          color: AppColors.subtitleTextColor,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(10.h),

              RetryButton(
                onTap: () {
                  controller.refreshApplications();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
