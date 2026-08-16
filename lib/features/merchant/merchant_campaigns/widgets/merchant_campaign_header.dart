import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/features/merchant/merchant_campaigns/controller/merchant_campaigns_controller.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../utils/enum/app_enum.dart';

class MerchantCampaignHeader extends StatelessWidget {
  const MerchantCampaignHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MerchantCampaignsController.to;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 22.h),

      decoration: BoxDecoration(
        color: AppColors.primaryColor,

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  //
                  AppRouter.route.goNamed(RoutePath.navigationPages);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),

              Gap(8.w),

              Text(
                AppStrings.influencerCampaigns.tr,
                style: context.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          Gap(18.h),

          Text(
            AppStrings.influencerCampaignsDescription.tr,
            style: context.bodySmall.copyWith(color: Colors.white),
          ),

          Gap(18.h),

          Obx(
            () => ApiStatusBuilder(
              status: controller.summaryLoading.value
                  ? ApiStatus.loading
                  : ApiStatus.completed,

              errorMessage: controller.summaryError.value,

              onRetry: controller.refreshCampaigns,

              loadingWidget: Row(
                children: [
                  _stat(
                    context,
                    AppStrings.activeCampaign.tr,
                    null,
                    isLoading: true,
                  ),

                  Gap(12.w),

                  _stat(context, AppStrings.inReview.tr, null, isLoading: true),
                ],
              ),

              builder: (context) {
                return Row(
                  children: [
                    _stat(
                      context,
                      AppStrings.activeCampaign.tr,
                      "${controller.summaryCampaigns.value?.active ?? 0}",
                    ),

                    Gap(12.w),

                    _stat(
                      context,
                      AppStrings.inReview.tr,
                      "${controller.summaryCampaigns.value?.inReview ?? 0}",
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(
    BuildContext context,
    String title,
    String? value, {
    bool isLoading = false,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.bodySmall),

            Gap(4.h),

            isLoading
                ? AutoShimmerAnimate(
                    isLoading: true,
                    baseColor: AppColors.shimmerBaseColor,
                    child: Container(
                      width: 35.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  )
                : Text(
                    value ?? "0",
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  //
}
