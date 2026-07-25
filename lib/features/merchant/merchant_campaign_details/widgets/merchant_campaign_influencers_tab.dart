import '../../../../share/controller/screen_export.dart';
import '../controller/merchant_campaign_details_controller.dart';
import 'merchant_campaign_influencer_card.dart';

class MerchantCampaignInfluencersTab
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignInfluencersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _infoBanner(context),

        Gap(14.h),

        ...controller.influencers.map(
          (e) => Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: MerchantCampaignInfluencerCard(data: e),
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
}
