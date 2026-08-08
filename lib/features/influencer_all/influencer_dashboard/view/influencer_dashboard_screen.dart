import 'package:som_spot/features/influencer_all/influencer_dashboard/controller/influencer_dashboard_controller.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../common_components/dash_common_header.dart';
import '../../../common_components/dash_common_header_cont.dart';
import '../widgets/influencer_active_tasks.dart';
import '../widgets/influencer_earnings_card.dart';
import '../widgets/influencer_performance_grid.dart';

class InfluencerDashboardScreen extends StatelessWidget {
  const InfluencerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InfluencerDashboardController.to;
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,

      body: CustomRefreshIndicator(
        onRefresh: controller.refreshHomeData,

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              _headerSection(controller),

              Gap(20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    _performanceSection(context),

                    Gap(20.h),

                    _activeTasksSection(context),

                    Gap(30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // Header
  // ==========================================================

  Widget _headerSection(InfluencerDashboardController controller) {
    return DashCommonHeaderCont(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Obx(
            () => ApiStatusBuilder(
              status: controller.dashboardStatus.value,

              errorMessage: controller.errorMessage.value,

              onRetry: controller.getDashboardOverview,

              loadingWidget: DashboardCommonHeaderSecShimmer(),

              builder: (_) {
                final data = controller.dashboardData!;

                return DashboardCommonHeaderSec(
                  data: DashboardHeaderModel(
                    userName: data.name.obs,
                    userProfileImage: data.profileImage.obs,
                    userAddress: data.location.obs,
                  ),
                );
              },
            ),
          ),

          Gap(16.h),

          Obx(
            () => ApiStatusBuilder(
              status: controller.dashboardStatus.value,

              errorMessage: controller.errorMessage.value,

              onRetry: controller.getDashboardOverview,

              loadingWidget: InfluencerEarningsCard(isLoading: true),

              builder: (_) {
                return InfluencerEarningsCard(
                  isLoading: false,
                  data: controller.dashboardData!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  // ==========================================================
  // Performance
  // ==========================================================

  Widget _performanceSection(BuildContext context) {
    final controller = InfluencerDashboardController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          AppStrings.performance.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.darkTextColor,
          ),
        ),

        Gap(12.h),

        Obx(
          () => ApiStatusBuilder(
            status: controller.dashboardStatus.value,

            errorMessage: controller.errorMessage.value,

            onRetry: controller.getDashboardOverview,

            loadingWidget: InfluencerPerformanceGrid(isLoading: true),

            builder: (_) {
              return InfluencerPerformanceGrid(
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
  // Active Tasks
  // ==========================================================

  Widget _activeTasksSection(BuildContext context) {
    final controller = InfluencerDashboardController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              AppStrings.activeTasks.tr,
              style: context.titleMedium.copyWith(fontWeight: FontWeight.w700),
            ),

            GestureDetector(
              onTap: () {
                NavigationControllerMain.to.goToTabTasks();
              },

              child: Text(
                AppStrings.viewAll.tr,
                style: context.bodySmall.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),

        Gap(12.h),

        Obx(
          () => ApiStatusBuilder(
            status: controller.dashboardStatus.value,

            errorMessage: controller.errorMessage.value,

            onRetry: controller.getDashboardOverview,

            loadingWidget: InfluencerActiveTasks(isLoading: true, data: null),

            builder: (_) {
              return InfluencerActiveTasks(
                isLoading: false,
                data: controller.dashboardData,
              );
            },
          ),
        ),
      ],
    );
  }
}
