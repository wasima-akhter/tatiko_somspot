import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';

double get taskTabheight => 40.h;

class TaskTabs extends StatelessWidget {
  const TaskTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: taskTabheight,
      color: Colors.white,
      child: DefaultTabController(
        length: 3,
        child: TabBar(
          padding: EdgeInsets.symmetric(horizontal: 20),
          dividerColor: AppColors.grayTertiaryTextColor,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
          tabs: const [
            Tab(text: "Active", ),
            Tab(text: "Review"),
            Tab(text: "Done"),
          ],
        ),
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
