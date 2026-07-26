import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/features/merchant/dashboard_merchant/controller/dashboard_merchant_controller.dart';
import 'package:som_spot/features/merchant/dashboard_merchant/widgets/activity_grid.dart';
import 'package:som_spot/features/merchant/dashboard_merchant/widgets/dashboard_header.dart';
import 'package:som_spot/features/merchant/dashboard_merchant/widgets/overview_grid.dart';
import 'package:som_spot/features/merchant/dashboard_merchant/widgets/recent_claims_list.dart';
import 'package:som_spot/features/merchant/dashboard_merchant/widgets/top_deals_list.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../response/dashboard_merchant_response.dart';
import '../widgets/campaign_card_navigator.dart';
import '../widgets/dashboard_section_title.dart';

class DashboardMerchantScreen extends StatefulWidget {
  const DashboardMerchantScreen({super.key});

  @override
  State<DashboardMerchantScreen> createState() =>
      _DashboardMerchantScreenState();
}

class _DashboardMerchantScreenState extends State<DashboardMerchantScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await DashboardMerchantController.to.refreshHomeData();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(),

              Gap(20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: AutoShimmerAnimate(
                  isLoading: _isLoading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // campaign section
                      _influencerCampaignSection(context),
                      Gap(24.h),

                      _overviewSection(context),

                      Gap(24.h),

                      _activitySummarySection(context),

                      Gap(24.h),

                      _topDealsSection(context),

                      Gap(24.h),

                      _recentClaimsSection(context),

                      Gap(32.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // Header Section
  // ==========================================================
  Widget _headerSection() {
    return const DashboardHeader();
  }

  // ==========================================================
  // Overview Section
  // ==========================================================
  Widget _overviewSection(BuildContext context) {
    final controller = DashboardMerchantController.to;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardSectionTitle(title: AppStrings.overview.tr),

        Gap(12.h),

        Obx(
          () => ApiStatusBuilder(
            status: controller.dashboardStatus.value,
            errorMessage: controller.errorMessage.value,
            onRetry: controller.getDashboardOverview,

            loadingWidget: OverviewGrid(
              isLoading: true,
              data: MerchantDashboardModel.empty(),
            ),

            builder: (_) {
              return OverviewGrid(
                isLoading: false,
                data: controller.dashboardData!,
              );
            },
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // Activity Summary Section
  // ==========================================================
  Widget _activitySummarySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardSectionTitle(title: AppStrings.activitySummary.tr),
        Gap(12.h),

        const ActivityGrid(),
      ],
    );
  }

  // ==========================================================
  // Top Deals Section
  // ==========================================================
  Widget _topDealsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardSectionTitle(title: AppStrings.topDeals.tr),

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
      ],
    );
  }

  // ==========================================================
  // Recent Claims Section
  // ==========================================================
  Widget _recentClaimsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardSectionTitle(title: AppStrings.recentClaims.tr),

        Gap(12.h),

        const RecentClaimsList(),
      ],
    );
  }

  Widget _influencerCampaignSection(BuildContext context) {
    return CampaignCardNavigator(
      title: "Influencer Campaigns",
      subtitle: "2 new applicants · 3 to review",
      onTap: () {
        AppRouter.route.pushNamed(RoutePath.merchantCampaignsScreen);
      },
    );
  }
}
