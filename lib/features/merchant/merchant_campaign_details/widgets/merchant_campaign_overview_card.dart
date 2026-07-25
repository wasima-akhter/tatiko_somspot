import '../../../../share/controller/screen_export.dart';
import '../controller/merchant_campaign_details_controller.dart';

class MerchantCampaignOverviewCard
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final campaign = controller.campaign;

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
              Expanded(child: _item("Budget", campaign["budget"] as String)),
              Expanded(
                child: _item("Creators", campaign["creators"] as String),
              ),
            ],
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(child: _item("Package", campaign["package"] as String)),
              Expanded(
                child: _item("Duration", campaign["duration"] as String),
              ),
            ],
          ),
        ],
      ),
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
