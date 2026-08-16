import '../../../../share/export/screen_export.dart';
import '../controller/merchant_campaign_details_controller.dart';
import '../helper/merchant_campaign_detail_helper.dart';

class MerchantCampaignDetailsTabs
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignDetailsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
      decoration: BoxDecoration(
        color: const Color(0xffF4F8FC),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Obx(
        () => Row(
          children: MerchantCampaignDetailsTab.values
              .map(
                (tab) => Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => controller.changeTab(tab),
                    child: _tab(tab.title, controller.selectedTab.value == tab),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _tab(String title, bool active) {
    return Container(
      margin: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            color: active
                ? AppColors.primaryColor
                : AppColors.subtitleTextColor,
          ),
        ),
      ),
    );
  }
}
