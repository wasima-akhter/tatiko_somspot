import '../../../../share/controller/screen_export.dart';
import '../controller/merchant_campaign_details_controller.dart';
import 'merchant_campaign_content_card.dart';

class MerchantCampaignContentTab
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignContentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: controller.contents
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: MerchantCampaignContentCard(data: e),
            ),
          )
          .toList(),
    );
  }
}
