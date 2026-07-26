import '../../../../share/controller/screen_export.dart';
import '../controller/influencer_discover_controller.dart';
import '../widgets/discover_category_tabs.dart';
import '../widgets/discover_header.dart';
import '../widgets/influencer_campaign_card.dart';

class InfluencerDiscoverScreen extends StatefulWidget {
  const InfluencerDiscoverScreen({super.key});

  @override
  State<InfluencerDiscoverScreen> createState() =>
      _InfluencerDiscoverScreenState();
}

class _InfluencerDiscoverScreenState extends State<InfluencerDiscoverScreen> {
  final InfluencerDiscoverController controller =
      InfluencerDiscoverController.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ScaffoldWrapper(
        backgroundColor: AppColors.softBackgroundColor,

        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            SliverToBoxAdapter(child: DiscoverHeader()),
            SliverPersistentHeader(
              pinned: true,

              delegate: DiscoverTabsDelegate(child: DiscoverCategoryTabs()),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),

              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final campaign = controller.campaigns[index];

                  return Obx(() {
                    return controller.isLoading.value
                        ? const CampaignCardSkeleton()
                        : InfluencerCampaignCard(campaign: campaign);
                  });
                }, childCount: controller.campaigns.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
