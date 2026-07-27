import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../response/dashboard_merchant_response.dart';
import 'dashboard_stat_card.dart';

class ActivityGrid extends StatelessWidget {
  final MerchantDashboardModel data;
  final bool isLoading;

  const ActivityGrid({super.key, required this.data, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final activity = data.activitySummary;

    return GridView.count(
      padding: EdgeInsets.zero,

      crossAxisCount: 2,

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      crossAxisSpacing: 16.w,

      mainAxisSpacing: 16.h,

      childAspectRatio: 1.6,

      children: [
        DashboardStatCard(
          title: AppStrings.visitors.tr,
          value: activity.visitors.toString(),
          icon: Iconsax.eye,
          iconColor: AppColors.blueAccentColor,
          isLoading: isLoading,
        ),

        DashboardStatCard(
          title: AppStrings.uniqueUsers.tr,
          value: activity.uniqueUsers.toString(),
          icon: Iconsax.user,
          iconColor: AppColors.purpleAccentColor,
          isLoading: isLoading,
        ),

        DashboardStatCard(
          title: AppStrings.engagement.tr,
          value: '${activity.engagementRate}%',
          icon: Iconsax.activity,
          iconColor: AppColors.emeraldGreenColor,
          isLoading: isLoading,
        ),

        DashboardStatCard(
          title: AppStrings.bounceRate.tr,
          value: '${activity.bounceRate}%',
          icon: Iconsax.trend_down,
          iconColor: AppColors.orangeColor,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
