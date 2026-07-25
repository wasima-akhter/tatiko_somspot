import 'package:som_spot/core/router/routes.dart';

import '../../../../share/controller/screen_export.dart';
import '../../merchant_campaigns/modules/merchant_campaign_tag.dart';
import '../controller/merchant_campaign_details_controller.dart';
import '../helper/merchant_campaign_detail_helper.dart';
import '../widgets/merchant_campaign_content_tab.dart';
import '../widgets/merchant_campaign_details_tabs.dart';
import '../widgets/merchant_campaign_influencers_tab.dart';
import '../widgets/merchant_campaign_overview_tab.dart';

class MerchantCampaignDetailsScreen extends StatelessWidget {
  const MerchantCampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,

      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorNew,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
          onPressed: () => AppRouter.route.pop(),
        ),
        title: Text(
          "Campaign",
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(10.h),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Buy 1 Get 1 Free Promo",
                            style: context.headlineSmall.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        MerchantCampaignStatusTag(
                          status: MerchantCampaignStatus.pending,
                        ),
                      ],
                    ),

                    Gap(6.h),

                    Text(
                      "Offer Campaign • \$35",
                      style: context.bodySmall.copyWith(
                        color: AppColors.subtitleTextColor,
                      ),
                    ),

                    Gap(14.h),
                    MerchantCampaignDetailsTabs(),
                    Gap(14.h),

                    Obx(() {
                      switch (MerchantCampaignDetailsController
                          .to
                          .selectedTab
                          .value) {
                        case MerchantCampaignDetailsTab.overview:
                          return const MerchantCampaignOverviewTab();

                        case MerchantCampaignDetailsTab.influencers:
                          return const MerchantCampaignInfluencersTab();

                        case MerchantCampaignDetailsTab.content:
                          return const MerchantCampaignContentTab();
                      }
                    }), // overview tab content.
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
