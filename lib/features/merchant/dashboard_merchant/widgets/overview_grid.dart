import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../response/dashboard_merchant_response.dart';
import 'dashboard_stat_card.dart';

class OverviewGrid extends StatelessWidget {
  final MerchantDashboardModel data;
  final bool isLoading;

  const OverviewGrid({super.key, required this.data, required this.isLoading});

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
          value: data.totalViews.toString(),
          icon: Iconsax.profile_2user,
          iconColor: AppColors.blueAccentColor,
          isLoading: isLoading,
        ),

        DashboardStatCard(
          title: AppStrings.activeOffers.tr,
          value: data.activeOffers.toString(),
          icon: Iconsax.tag,
          iconColor: AppColors.purpleAccentColor,
          isLoading: isLoading,
        ),

        DashboardStatCard(
          title: AppStrings.claims.tr,
          value: data.totalClaims.toString(),
          icon: Iconsax.trend_up,
          iconColor: AppColors.emeraldGreenColor,
          isLoading: isLoading,
        ),

        DashboardStatCard(
          title: AppStrings.estRevenue.tr,
          value: "\$${data.estRevenue}",
          icon: Icons.attach_money_rounded,
          iconColor: AppColors.amberYellowColor,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
