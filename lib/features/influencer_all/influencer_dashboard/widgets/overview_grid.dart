import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'dashboard_stat_card.dart';

class OverviewGrid extends StatelessWidget {
  const OverviewGrid({super.key});

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
          title: AppStrings.totalViews.tr,
          value: '2,450',
          icon: Iconsax.profile_2user,
          iconColor: AppColors.blueAccentColor,
        ),
        DashboardStatCard(
          title: AppStrings.activeOffers.tr,
          value: '03',
          icon: Iconsax.tag,
          iconColor: AppColors.purpleAccentColor,
        ),
        DashboardStatCard(
          title: AppStrings.claims.tr,
          value: '180',
          icon: Iconsax.trend_up,
          iconColor: AppColors.emeraldGreenColor,
        ),
        DashboardStatCard(
          title: AppStrings.estRevenue.tr,
          value: '\$2,450',
          icon: Icons.attach_money_rounded,
          iconColor: AppColors.amberYellowColor,
        ),
      ],
    );
  }
}
