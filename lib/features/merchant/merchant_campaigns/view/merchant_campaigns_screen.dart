import 'package:som_spot/features/merchant/merchant_campaigns/widgets/merchant_campaign_header.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../controller/merchant_campaigns_controller.dart';
import '../widgets/campaign_create_button.dart';
import '../widgets/campaign_tabs.dart';
import '../widgets/merchant_campaign_card.dart';

class MerchantCampaignScreen extends StatefulWidget {
  const MerchantCampaignScreen({super.key});

  @override
  State<MerchantCampaignScreen> createState() => _MerchantCampaignScreenState();
}

class _MerchantCampaignScreenState extends State<MerchantCampaignScreen> {
  final controller = MerchantCampaignsController.to;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

      child: Scaffold(
        backgroundColor: AppColors.backgroundColorNew,

        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            const SliverToBoxAdapter(child: MerchantCampaignHeader()),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),

              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    CampaignCreateButton(
                      onTap: () {
                        // MerchantNewCampaignScreen

                        AppRouter.route.pushNamed(
                          RoutePath.merchantNewCampaignScreen,
                        );
                      },
                    ),

                    Gap(16.h),

                    Obx(
                      () => CampaignTabs(
                        selected: controller.selectedTab.value,
                        onChange: controller.changeTab,
                      ),
                    ),

                    Gap(16.h),

                    Obx(() {
                      return ApiStatusBuilder(
                        status: controller.paginator.status.value,

                        errorMessage: controller.paginator.errorMessage.value,

                        onRetry: controller.refreshCampaigns,

                        isLoadingMore:
                            controller.paginator.loadMoreStatus.value ==
                            ApiStatus.loading,

                        hasMore: controller.paginator.hasMore.value,

                        builder: (context) {
                          final items = controller.campaigns;

                          if (items.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(top: 40.h),

                              child: Text(
                                "No campaigns found",

                                style: context.bodyMedium.copyWith(
                                  color: AppColors.subtitleTextColor,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,

                            physics: const NeverScrollableScrollPhysics(),

                            controller: controller.listScrollController,

                            padding: EdgeInsets.zero,

                            itemCount: items.length,

                            itemBuilder: (_, index) {
                              final campaign = items[index];

                              return MerchantCampaignCard(campaign: campaign);
                            },
                          );
                        },
                      );
                    }),
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
