import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../dashboard/widgets/dashboard_stat_card.dart';

class InfluencerPerformanceGrid extends StatelessWidget {
  const InfluencerPerformanceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DashboardStatCard(
            title: "Total Views",
            value: "45K",
            icon: Iconsax.eye,
            iconColor: AppColors.blueAccentColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: DashboardStatCard(
            title: "Total Clicks",
            value: "3.2K",
            icon: Iconsax.magic_star,
            iconColor: AppColors.purpleAccentColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: DashboardStatCard(
            title: "Claims",
            value: "480",
            icon: Iconsax.tick_circle,
            iconColor: AppColors.emeraldGreenColor,
          ),
        ),
      ],
    );
  }
}
