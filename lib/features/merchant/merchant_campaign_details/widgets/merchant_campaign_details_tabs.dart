import 'package:som_spot/share/language/controller/language_controller.dart';

import '../../../../share/export/screen_export.dart';
import '../controller/merchant_campaign_details_controller.dart';
import '../helper/merchant_campaign_detail_helper.dart';

class MerchantCampaignDetailsTabs
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignDetailsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        color: const Color(0xffF4F8FC),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(3.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: MerchantCampaignDetailsTab.values.map((tab) {
                  final active = controller.selectedTab.value == tab;

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => controller.changeTab(tab),
                    child: _tab(context, tab.title, active),
                  );
                }).toList(),
              ),
            ),
          ),

          // Right-side scroll hint
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                width: 28.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xffF4F8FC).withValues(alpha: 0),
                      const Color(0xffF4F8FC),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(BuildContext context, String title, bool active) {
    final isSomali =
        LanguageController.to.selectedLanguage.value == AppLanguage.somali;
    return Container(
      constraints: BoxConstraints(
        minWidth: 42.w,
        maxWidth: isSomali ? 140.w : 100.w,
      ),
      // margin: EdgeInsets.symmetric(horizontal: 2.w),
      // padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: active ? FontWeight.w600 : FontWeight.w400,
          color: active ? AppColors.primaryColor : AppColors.subtitleTextColor,
        ),
      ),
    );
  }
}
