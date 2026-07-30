import 'package:som_spot/features/merchant/merchant_campaigns/widgets/merchant_campaign_header.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
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
                        status: controller.apiStatus.value,

                        errorMessage: controller.errorMessage.value,

                        onRetry: controller.refreshCampaigns,

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

                          return Column(
                            children: items.map((campaign) {
                              return MerchantCampaignCard(campaign: campaign);
                            }).toList(),
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
