import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
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
