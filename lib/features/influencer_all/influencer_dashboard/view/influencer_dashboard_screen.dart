import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/dashboard/widgets/activity_grid.dart';
import 'package:som_spot/features/dashboard/widgets/dashboard_header.dart';
import 'package:som_spot/features/dashboard/widgets/overview_grid.dart';
import 'package:som_spot/features/dashboard/widgets/recent_claims_list.dart';
import 'package:som_spot/features/dashboard/widgets/top_deals_list.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class InfluencerDashboardScreen extends StatefulWidget {
  const InfluencerDashboardScreen({super.key});

  @override
  State<InfluencerDashboardScreen> createState() =>
      _InfluencerDashboardScreenState();
}

class _InfluencerDashboardScreenState extends State<InfluencerDashboardScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Section (always visible) ──
            const DashboardHeader(),
            Gap(20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AutoShimmerAnimate(
                isLoading: _isLoading,
                child: _buildDashboardContent(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  //  Dashboard Content
  // ══════════════════════════════════════════════════════════
  Widget _buildDashboardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Overview Section ──
        Text(
          AppStrings.overview.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        Gap(12.h),
        const OverviewGrid(),
        Gap(24.h),

        // ── Activity Summary Section ──
        Text(
          AppStrings.activitySummary.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        Gap(12.h),
        const ActivityGrid(),
        Gap(24.h),

        // ── Top Deals Section ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.topDeals.tr,
              style: context.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextColor,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.emoji_events_outlined,
                  size: 14.sp,
                  color: AppColors.amberYellowColor,
                ),
                Gap(4.w),
                Text(
                  AppStrings.rankedByClaims.tr,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(12.h),
        const TopDealsList(),
        Gap(24.h),

        // ── Recent Claims Section ──
        Text(
          AppStrings.recentClaims.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        Gap(12.h),
        const RecentClaimsList(),
        Gap(32.h),
      ],
    );
  }
}
