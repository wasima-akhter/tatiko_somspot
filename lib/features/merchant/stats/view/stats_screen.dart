import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/features/merchant/stats/widgets/analytics_header.dart';
import 'package:som_spot/features/merchant/stats/widgets/analytics_overview_grid.dart';
import 'package:som_spot/features/merchant/stats/widgets/top_performing_offers_list.dart';
import 'package:som_spot/features/merchant/stats/widgets/top_deals_analytics_list.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            const AnalyticsHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: AutoShimmerAnimate(
                isLoading: _isLoading,
                child: Column(
                  children: [
                    const AnalyticsOverviewGrid(),
                    Gap(32.h),
                    const TopPerformingOffersList(),
                    Gap(32.h),
                    const TopDealsAnalyticsList(),
                    Gap(40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
