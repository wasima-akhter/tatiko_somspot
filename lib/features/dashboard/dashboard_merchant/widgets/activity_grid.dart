import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'dashboard_stat_card.dart';

class ActivityGrid extends StatelessWidget {
  const ActivityGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
          value: '2,450',
          icon: Iconsax.eye,
          iconColor: AppColors.blueAccentColor,
        ),
        DashboardStatCard(
          title: AppStrings.uniqueUsers.tr,
          value: '250',
          icon: Iconsax.user,
          iconColor: AppColors.purpleAccentColor,
        ),
        DashboardStatCard(
          title: AppStrings.engagement.tr,
          value: '80%',
          icon: Iconsax.activity,
          iconColor: AppColors.emeraldGreenColor,
        ),
        DashboardStatCard(
          title: AppStrings.bounceRate.tr,
          value: '18%',
          icon: Iconsax.trend_down,
          iconColor: AppColors.orangeColor,
        ),
      ],
    );
  }
}
