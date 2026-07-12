import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../controller/influencer_discover_controller.dart';

double get discoverCategoryTabHeight => 40.h;

class DiscoverCategoryTabs extends StatelessWidget {
  const DiscoverCategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InfluencerDiscoverController.to;
    return Obx(
      () => Container(
        height: discoverCategoryTabHeight,
        color: AppColors.softBackgroundColor,

        padding: EdgeInsets.symmetric(horizontal: 20.w),

        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            children: List.generate(controller.categories.length, (index) {
              final selected = controller.selectedTab.value == index;

              return GestureDetector(
                onTap: () {
                  controller.selectedTab.value = index;
                },

                child: Container(
                  margin: EdgeInsets.only(right: 10.w),

                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),

                  decoration: BoxDecoration(
                    color: selected ? AppColors.primaryColor : Colors.white,

                    borderRadius: BorderRadius.circular(20.r),
                  ),

                  child: Text(
                    controller.categories[index],

                    style: TextStyle(
                      fontSize: 12.sp,

                      color: selected ? Colors.white : Colors.grey,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class DiscoverTabsDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  DiscoverTabsDelegate({required this.child});

  @override
  double get minExtent => discoverCategoryTabHeight;

  @override
  double get maxExtent => discoverCategoryTabHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(height: discoverCategoryTabHeight, child: child);
  }

  @override
  bool shouldRebuild(covariant DiscoverTabsDelegate oldDelegate) {
    return false;
  }
}
