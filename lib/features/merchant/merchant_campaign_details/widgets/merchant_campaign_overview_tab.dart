import '../../../../share/controller/screen_export.dart';
import 'merchant_campaign_overview_card.dart';
import 'merchant_campaign_timeline.dart';

class MerchantCampaignOverviewTab extends StatelessWidget {
  const MerchantCampaignOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MerchantCampaignOverviewCard(),

        Gap(14.h),

        Text(
          "Campaign Timeline",
          style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
        ),

        Gap(10.h),

        const MerchantCampaignTimeline(),

        Gap(20.h),
      ],
    );
  }
}
