import 'package:som_spot/features/merchant/stats/widgets/analytics_header.dart';
import 'package:som_spot/features/merchant/stats/widgets/analytics_overview_grid.dart';
import 'package:som_spot/features/merchant/stats/widgets/top_deals_analytics_list.dart';
import 'package:som_spot/features/merchant/stats/widgets/top_performing_offers_list.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/stats_controller.dart';

class StatsScreen extends GetView<StatsController> {
  const StatsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await controller.loadAnalytics();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              const AnalyticsHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  children: [
                    const AnalyticsOverviewGrid(),
                    Gap(32.h),
                    Obx(
                      () => ApiStatusBuilder(
                        status: controller.status.value,
                        errorMessage: controller.errorMessage.value,
                        onRetry: controller.loadAnalytics,
                        builder: (_) =>
                            Column(children: [const TopPerformingOffersList()]),
                      ),
                    ),
                    Gap(32.h),
                    const TopDealsAnalyticsList(),
                    Gap(40.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
