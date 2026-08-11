import 'package:som_spot/share/controller/screen_export.dart';

import '../../merchant_new_campaign/shared/helper/campaign_helper.dart';

class CampaignTabs extends StatelessWidget {
  final MerchantCampaignTab selected;
  final ValueChanged<MerchantCampaignTab> onChange;

  const CampaignTabs({
    super.key,
    required this.selected,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = {
      MerchantCampaignTab.all: AppStrings.all.tr,
      MerchantCampaignTab.pending: AppStrings.pending.tr,
      MerchantCampaignTab.live: AppStrings.live.tr,
    };

    return Row(
      children: tabs.entries.map((entry) {
        final tab = entry.key;

        final active = selected == tab;

        return GestureDetector(
          onTap: () => onChange(tab),

          child: Container(
            margin: EdgeInsets.only(right: 10.w),

            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),

            decoration: BoxDecoration(
              color: active ? AppColors.primaryColor : AppColors.white,

              borderRadius: BorderRadius.circular(20.r),
            ),

            child: Text(
              entry.value,

              style: context.bodySmall.copyWith(
                fontSize: 11.sp,

                fontWeight: active ? FontWeight.w600 : FontWeight.w500,

                color: active ? Colors.white : AppColors.subtitleTextColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
