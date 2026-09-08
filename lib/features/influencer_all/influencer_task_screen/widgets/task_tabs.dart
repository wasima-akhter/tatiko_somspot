import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';
import '../helper/influencer_task_helper.dart';

double get taskTabheight => 40.h;

class TaskTabs extends StatelessWidget {
  final TabController controller;

  const TaskTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: taskTabheight,
      color: Colors.white,
      child: TabBar(
        controller: controller,
        isScrollable: true,

        padding: const EdgeInsets.symmetric(horizontal: 15),
        tabAlignment: TabAlignment.center,

        dividerColor: AppColors.grayTertiaryTextColor,
        indicatorColor: AppColors.primaryColor,
        indicatorWeight: 2,

        labelColor: AppColors.primaryColor,
        unselectedLabelColor: Colors.grey,

        labelPadding: const EdgeInsets.symmetric(horizontal: 14),

        tabs: InfluencerTaskTab.values
            .map(
              (e) => Tab(
                child: Text(
                  e.title,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TaskTabsDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  TaskTabsDelegate({required this.child});

  @override
  double get minExtent => taskTabheight;

  @override
  double get maxExtent => taskTabheight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
