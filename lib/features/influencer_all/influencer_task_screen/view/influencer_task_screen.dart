import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../widgets/influencer_task_card.dart';
import '../widgets/task_header.dart';
import '../widgets/task_tabs.dart';

class InfluencerTaskScreen extends StatefulWidget {
  const InfluencerTaskScreen({super.key});

  @override
  State<InfluencerTaskScreen> createState() => _InfluencerTaskScreenState();
}

class _InfluencerTaskScreenState extends State<InfluencerTaskScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => isLoading = false);
      }
    });
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
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.softBackgroundColor,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: TaskHeader()),

            SliverPersistentHeader(
              pinned: true,
              delegate: TaskTabsDelegate(child: TaskTabs()),
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return AutoShimmerAnimate(
                    isLoading: isLoading,
                    child: InfluencerTaskCard(task: tasks[index]),
                  );
                }, childCount: tasks.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
