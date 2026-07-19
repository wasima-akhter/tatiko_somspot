import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../../../common_components/dash_common_header_cont.dart';
import '../widgets/influencer_active_tasks.dart';
import '../widgets/influencer_earnings_card.dart';
import '../widgets/influencer_performance_grid.dart';

class InfluencerDashboardScreen extends StatefulWidget {
  const InfluencerDashboardScreen({super.key});

  @override
  State<InfluencerDashboardScreen> createState() =>
      _InfluencerDashboardScreenState();
}

class _InfluencerDashboardScreenState extends State<InfluencerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashCommonHeaderCont(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // DashboardCommonHeaderSec(),
                  Gap(16.h),
                  InfluencerEarningsCard(),
                ],
              ),
            ),
            Gap(12.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Performance",
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  Gap(12.h),

                  InfluencerPerformanceGrid(),
                  Gap(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Active Tasks",
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          NavigationControllerMain.to.goToTabTasks();
                        },
                        child: Text(
                          "View all",
                          style: context.bodySmall.copyWith(
                            // color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(12.h),

                  InfluencerActiveTasks(),
                ],
              ),
            ),

            Gap(30.h),
          ],
        ),
      ),
    );
  }
}
