import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../share/controller/screen_export.dart';
import '../../merchant_campaigns/modules/merchant_campaign_tag.dart';
import '../../merchant_new_campaign/shared/helper/campaign_helper.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_detail_model.dart';
import '../controller/merchant_campaign_details_controller.dart';
import '../helper/merchant_campaign_detail_helper.dart';
import '../widgets/merchant_campaign_content_tab.dart';
import '../widgets/merchant_campaign_details_tabs.dart';
import '../widgets/merchant_campaign_influencers_tab.dart';
import '../widgets/merchant_campaign_overview_tab.dart';
import '../widgets/merchant_campaign_published_tab.dart';

/*
class MerchantCampaignDetailsScreen extends StatelessWidget {
  const MerchantCampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: "Campaign Details",
      onPressed: () => AppRouter.route.pop(),

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
                          child: Obx(
                            () => Text(
                              (MerchantCampaignDetailsController
                                          .to
                                          .campaign
                                          .value
                                          ?.name ??
                                      '')
                                  .capitalizeWords(),
                              style: context.headlineSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Obx(
                          () => MerchantCampaignStatusTag(
                            status: MerchantCampaignStatusExtension.fromApi(
                              MerchantCampaignDetailsController
                                      .to
                                      .campaign
                                      .value
                                      ?.status ??
                                  '',
                            ),
                          ),
                        ),
                      ],
                    ),

                    Gap(6.h),
                    Obx(() {
                      final campaign =
                          MerchantCampaignDetailsController.to.campaign.value;

                      final offerText = campaign?.offer != null
                          ? "${campaign!.offer!.title.capitalizeWords()} ${campaign.offer!.discountLabel}"
                          : null;

                      final budgetText =
                          "Budget: \$${campaign?.totalBudget.toStringAsFixed(0) ?? "0"}";

                      return Text(
                        [
                          if (offerText != null && offerText.trim().isNotEmpty)
                            offerText,
                          budgetText,
                        ].join(" • "),
                        style: context.bodySmall.copyWith(
                          color: AppColors.subtitleTextColor,
                        ),
                      );
                    }),

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
                        case MerchantCampaignDetailsTab.published:
                          return const MerchantCampaignPublishedTab();
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
*/

class MerchantCampaignDetailsScreen
    extends GetView<MerchantCampaignDetailsController> {
  const MerchantCampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: "Campaign Details",
      onPressed: AppRouter.route.pop,

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

                    const _CampaignHeader(),

                    Gap(14.h),

                    const MerchantCampaignDetailsTabs(),

                    Gap(14.h),

                    const _CampaignTabContent(),
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

class _CampaignHeader extends GetView<MerchantCampaignDetailsController> {
  const _CampaignHeader();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final campaign = controller.campaign.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  (campaign?.name ?? "").capitalizeWords(),

                  style: context.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              MerchantCampaignStatusTag(
                status: MerchantCampaignStatusExtension.fromApi(
                  campaign?.status ?? "",
                ),
              ),
            ],
          ),

          Gap(6.h),

          Text(
            _subtitle(campaign),

            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
        ],
      );
    });
  }

  String _subtitle(MerchantCampaignDetailsModel? campaign) {
    final offer = campaign?.offer;

    final offerText = offer != null
        ? "${offer.title.capitalizeWords()} ${offer.discountLabel}"
        : null;

    final budget =
        "Budget: \$${campaign?.totalBudget.toStringAsFixed(0) ?? "0"}";

    return [
      if (offerText != null && offerText.trim().isNotEmpty) offerText,

      budget,
    ].join(" • ");
  }
}

class _CampaignTabContent extends GetView<MerchantCampaignDetailsController> {
  const _CampaignTabContent();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.selectedTab.value) {
        case MerchantCampaignDetailsTab.overview:
          return const MerchantCampaignOverviewTab();

        case MerchantCampaignDetailsTab.influencers:
          return const MerchantCampaignInfluencersTab();

        case MerchantCampaignDetailsTab.content:
          return const MerchantCampaignContentTab();

        case MerchantCampaignDetailsTab.published:
          return const MerchantCampaignPublishedTab();
      }
    });
  }
}
