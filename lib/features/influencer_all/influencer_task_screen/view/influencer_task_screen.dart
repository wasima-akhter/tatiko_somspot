import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../share/controller/screen_export.dart';
import '../widgets/completed_task_card.dart';
import '../widgets/influencer_task_card.dart';
import '../widgets/review_tab.dart';
import '../widgets/task_header.dart';
import '../widgets/task_tabs.dart';

class InfluencerTaskScreen extends StatefulWidget {
  const InfluencerTaskScreen({super.key});

  @override
  State<InfluencerTaskScreen> createState() => _InfluencerTaskScreenState();
}

class _InfluencerTaskScreenState extends State<InfluencerTaskScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => isLoading = false);
      }
    });

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {
        "merchant": "Lilido Beach Cafe",
        "title": "Sunset Coffee Promotion",
        "deliverable": "2 Instagram Stories",
        "approved": false,
      },
      {
        "merchant": "Lilido Beach Cafe",
        "title": "Sunset Coffee Promotion",
        "deliverable": "2 Instagram Stories",
        "approved": false,
      },
      {
        "merchant": "Lilido Beach Cafe",
        "title": "Sunset Coffee Promotion",
        "deliverable": "2 Instagram Stories",
        "approved": true,
        "note":
            "Looks fantastic — the BOGO call-out is crystal clear. Approved! Download the final cut and post it on TikTok.",
      },
    ];

    final completedTasks = [
      {
        "merchant": "Somali Tech Store",
        "title": "New iPhone Launch",
        "deliverable": "1 YouTube Short",
        "earned": "125.00",
      },
      {
        "merchant": "Somali Tech Store",
        "title": "New iPhone Launch",
        "deliverable": "1 YouTube Short",
        "earned": "125.00",
      },
    ];
    return SafeArea(
      top: false,
      child: ScaffoldWrapper(
        backgroundColor: AppColors.softBackgroundColor,
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
                child: Builder(
                  builder: (_) {
                    switch (_tabController.index) {
                      case 0:
                        return _buildActive(tasks);

                      case 1:
                        return _buildReview();

                      case 2:
                        return _buildDone(completedTasks);

                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActive(List<Map<String, dynamic>> tasks) {
    final active = tasks.where((e) => e["approved"] == false).toList();

    return Column(
      children: List.generate(
        tasks.length,

        (index) => AutoShimmerAnimate(
          isLoading: isLoading,

          child: InfluencerTaskCard(task: tasks[index]),
        ),
      ),
    );
  }

  Widget _buildDone(List<Map<String, dynamic>> completedTasks) {
    return Column(
      children: completedTasks.map((e) => CompletedTaskCard(task: e)).toList(),
    );
  }

  Widget _buildReview() {
    return const SizedBox(height: 700, child: ReviewTab());
  }
}
