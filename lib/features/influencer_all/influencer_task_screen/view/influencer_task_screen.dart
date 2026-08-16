import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../core/influencer_tasks/response/influencer_tasks_response.dart';
import '../controller/influencer_task_controller.dart';
import '../helper/influencer_task_helper.dart';
import '../widgets/influencer_active_task_card.dart';
import '../widgets/influencer_completed_task_card.dart';
import '../widgets/influencer_pending_task_card.dart';
import '../widgets/influencer_published_task_card.dart';
import '../widgets/task_header.dart';
import '../widgets/task_tabs.dart';

class InfluencerTaskScreen extends StatefulWidget {
  const InfluencerTaskScreen({super.key});

  @override
  State<InfluencerTaskScreen> createState() => _InfluencerTaskScreenState();
}

class _InfluencerTaskScreenState extends State<InfluencerTaskScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final controller = InfluencerTaskController.to;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: InfluencerTaskTab.values.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        controller.changeTab(_tabController.index);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadTasks();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            const SliverToBoxAdapter(child: TaskHeader()),

            SliverPersistentHeader(
              pinned: true,
              delegate: TaskTabsDelegate(
                child: TaskTabs(controller: _tabController),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              sliver: SliverToBoxAdapter(
                child: Obx(
                  () => ApiStatusBuilder(
                    status: controller.paginator.status.value,
                    errorMessage: controller.paginator.errorMessage.value,
                    onRetry: controller.loadTasks,
                    isLoadingMore:
                        controller.paginator.loadMoreStatus.value ==
                        ApiStatus.loading,
                    hasMore: controller.paginator.hasMore.value,

                    builder: (_) {
                      return ListView.builder(
                        controller: controller.listScrollController,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: controller.paginator.items.length,
                        itemBuilder: (_, index) {
                          final task = controller.paginator.items[index];

                          switch (controller.selectedTab.value) {
                            case InfluencerTaskTab.active:
                              return InfluencerTaskActiveCard(task: task);

                            case InfluencerTaskTab.pending:
                              return InfluencerTaskPendingCard(task: task);

                            case InfluencerTaskTab.completed:
                              return InfluencerTaskCompletedCard(task: task);

                            case InfluencerTaskTab.published:
                              return InfluencerTaskPublishedCard(task: task);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final mockInfluencerTask = InfluencerTaskModel(
  id: "task_001",

  creator: "creator_001",

  status: "pending",

  draftApproved: false,

  commissionAmount: 150,

  stage: "content_review",

  approvedAt: null,

  appliedAt: DateTime.now().subtract(const Duration(days: 3)),

  createdAt: DateTime.now().subtract(const Duration(days: 5)),

  updatedAt: DateTime.now().subtract(const Duration(hours: 6)),

  version: 1,

  draftMediaType: "video",

  draftVideoUrl: "https://example.com/videos/mock-campaign-video.mp4",

  submittedAt: DateTime.now().subtract(const Duration(hours: 8)),

  caption:
      "Check out this amazing product from our latest campaign! Don't miss out.",

  platform: "instagram",

  thumbnail: "https://example.com/images/mock-campaign-thumbnail.jpg",

  campaign: CampaignModel(
    id: "campaign_001",

    merchant: MerchantModel(id: "merchant_001", name: "SomSpot Store"),

    business: BusinessModel(
      id: "business_001",
      name: "SomSpot Business",
      logo: "https://example.com/images/business-logo.jpg",
    ),

    offer: "20% off",

    name: "Summer Product Campaign",

    about:
        "Create engaging short-form content showcasing our product and its benefits.",

    contentType: "video",

    endDate: DateTime.now().add(const Duration(days: 12)),

    videoLengthSec: 30,

    pricePerClaim: 150,
  ),
);

final List<InfluencerTaskModel> mockInfluencerTasks = [
  // Active
  InfluencerTaskModel(
    id: "active_001",
    creator: "creator_001",
    status: "active",
    draftApproved: false,
    commissionAmount: 150,
    stage: "active",
    createdAt: DateTime.now(),
    campaign: CampaignModel(
      id: "campaign_active",
      merchant: MerchantModel(id: "merchant_001", name: "SomSpot Store"),
      business: BusinessModel(id: "business_001", name: "SomSpot Business"),
      offer: "20% off",
      name: "Summer Campaign",
      about: "Create content for our summer campaign.",
      contentType: "video",
      endDate: DateTime.now().add(const Duration(days: 10)),
      videoLengthSec: 30,
      pricePerClaim: 150,
    ),
  ),

  // Pending
  InfluencerTaskModel(
    id: "pending_001",
    creator: "creator_002",
    status: "pending",
    draftApproved: false,
    commissionAmount: 200,
    stage: "pending",
    createdAt: DateTime.now(),
    campaign: CampaignModel(
      id: "campaign_pending",
      merchant: MerchantModel(id: "merchant_002", name: "Demo Brand"),
      business: BusinessModel(id: "business_002", name: "Demo Business"),
      offer: "15% off",
      name: "Product Launch",
      about: "Promote our newest product.",
      contentType: "video",
      endDate: DateTime.now().add(const Duration(days: 7)),
      videoLengthSec: 45,
      pricePerClaim: 200,
    ),
  ),

  // Completed
  InfluencerTaskModel(
    id: "completed_001",
    creator: "creator_003",
    status: "completed",
    draftApproved: true,
    commissionAmount: 250,
    stage: "completed",
    approvedAt: DateTime.now().subtract(const Duration(days: 1)),
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    submittedAt: DateTime.now().subtract(const Duration(days: 2)),
    draftMediaType: "video",
    platform: "instagram",
    caption: "Amazing product!",
    campaign: CampaignModel(
      id: "campaign_completed",
      merchant: MerchantModel(id: "merchant_003", name: "Demo Store"),
      business: BusinessModel(id: "business_003", name: "Demo Business"),
      offer: "25% off",
      name: "Creator Campaign",
      about: "Create content for our brand.",
      contentType: "video",
      endDate: DateTime.now().add(const Duration(days: 3)),
      videoLengthSec: 30,
      pricePerClaim: 250,
    ),
  ),

  // Published
  InfluencerTaskModel(
    id: "published_001",
    creator: "creator_004",
    status: "published",
    draftApproved: true,
    commissionAmount: 300,
    stage: "published",
    approvedAt: DateTime.now().subtract(const Duration(days: 4)),
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    submittedAt: DateTime.now().subtract(const Duration(days: 6)),
    draftMediaType: "video",
    platform: "tiktok",
    caption: "Check out this amazing product!",
    campaign: CampaignModel(
      id: "campaign_published",
      merchant: MerchantModel(id: "merchant_004", name: "SomSpot Brand"),
      business: BusinessModel(id: "business_004", name: "SomSpot Business"),
      offer: "30% off",
      name: "TikTok Campaign",
      about: "Promote our product on TikTok.",
      contentType: "video",
      endDate: DateTime.now().add(const Duration(days: 1)),
      videoLengthSec: 60,
      pricePerClaim: 300,
    ),
  ),
];
