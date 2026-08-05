import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../share/controller/screen_export.dart';
import '../../merchant_new_campaign/shared/helper/campaign_helper.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_model.dart';
import '../modules/merchant_campaign_tag.dart';

class MerchantCampaignCard extends StatelessWidget {
  final MerchantCampaignModel campaign;

  const MerchantCampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final progress = campaign.totalBudget == 0
        ? 0.0
        : campaign.spentBudget / campaign.totalBudget;

    return GestureDetector(
      onTap: () {
        //

        // if (Get.isRegistered<MerchantCampaignDetailsController>()) {
        //   Get.delete<MerchantCampaignDetailsController>(force: true);
        // }
        AppRouter.route.pushNamed(
          RoutePath.merchantCampaignDetailsScreen,
          extra: campaign.id,
        );
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),

        padding: EdgeInsets.all(12.w),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(14.r),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    campaign.name,

                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                MerchantCampaignStatusTag(
                  status: MerchantCampaignStatusExtension.fromApi(
                    campaign.status,
                  ),
                ),
              ],
            ),

            Gap(4.h),

            Text(
              (campaign.business?.name ?? "Campaign").capitalizeWords(),
              style: context.bodySmall.copyWith(
                color: AppColors.subtitleTextColor,
              ),
            ),

            Gap(12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Budget spent", style: context.bodySmall),

                Text(
                  campaign.budgetText,
                  style: context.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Gap(6.h),

            LinearProgressIndicator(
              value: progress.clamp(0, 1),

              backgroundColor: AppColors.backgroundsLinesColor,

              color: AppColors.primaryColor,
            ),

            Gap(10.h),

            Row(
              children: [
                Icon(
                  Iconsax.people,
                  size: 14.sp,
                  color: AppColors.primaryColor,
                ),

                Gap(4.w),

                Text(
                  "${campaign.assignedCount}/${campaign.targetCreators}",
                  style: context.bodySmall,
                ),

                Gap(12.w),

                Icon(Iconsax.clock, size: 14.sp),

                Gap(4.w),

                Text(campaign.daysLeftText, style: context.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
