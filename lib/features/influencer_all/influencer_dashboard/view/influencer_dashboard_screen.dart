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

class InfluencerDashboardScreen extends StatefulWidget {
  const InfluencerDashboardScreen({super.key});

  @override
  State<InfluencerDashboardScreen> createState() =>
      _InfluencerDashboardScreenState();
}

class _InfluencerDashboardScreenState extends State<InfluencerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = InfluencerDashboardController.to;
    final profileController = controller.profileController;
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,

      body: CustomRefreshIndicator(
        onRefresh: () async {
          await controller.profileController.getProfile();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashCommonHeaderCont(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => ApiStatusBuilder(
                        status: profileController.profileLoading.value,
                        errorMessage: profileController.errorMessage.value,
                        onRetry: profileController.getProfile,

                        loadingWidget: DashboardCommonHeaderSecShimmer(),
                        builder: (_) {
                          return DashboardCommonHeaderSec(
                            data: DashboardHeaderModel(
                              userName: controller.userName,
                              userProfileImage: controller.userProfileImage,
                              userAddress: controller.userAddress,
                            ),
                          );
                        },
                      ),
                    ),

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
      ),
    );
  }
}
