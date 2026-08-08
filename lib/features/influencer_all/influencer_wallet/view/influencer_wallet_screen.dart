import 'package:som_spot/features/influencer_all/influencer_wallet/helper/influencer_wallet_helper.dart';
import 'package:som_spot/features/influencer_all/influencer_wallet/widgets/earnings_trend_chart.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/influencer_wallet_controller.dart';
import '../widgets/active_tasks.dart';
import '../widgets/performance_grid.dart';
import '../widgets/top_content_list.dart';
import '../widgets/wallet_balance_card.dart';
import '../widgets/wallet_filter_tabs.dart';

class InfluencerWalletScreen extends StatelessWidget {
  const InfluencerWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InfluencerWalletController.to;
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(12.h),

              Text(
                AppStrings.wallet.tr,
                style: context.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
              ),

              Gap(18.h),

              const WalletBalanceCard(),

              Gap(14.h),

              Obx(
                () =>
                    controller.selectedTab.value == InfluencerWalletTab.withdraw
                    ? ActiveTasks()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WalletFilterTabs(),

                          Gap(20.h),

                          Text(
                            AppStrings.performance.tr,
                            style: context.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkTextColor,
                            ),
                          ),

                          Gap(18.h),

                          const PerformanceGrid(),

                          Gap(20.h),
                          Obx(
                            () => ApiStatusBuilder(
                              status: controller.walletStatus.value,
                              errorMessage: controller.errorMessage.value,
                              onRetry: controller.getWalletAnalytics,

                              loadingWidget: EarningsTrendChart(
                                earningsTrend: [],
                                isLoading: true,
                              ),

                              builder: (_) {
                                return EarningsTrendChart(
                                  earningsTrend:
                                      controller.walletData?.earningsTrend ??
                                      [],
                                );
                              },
                            ),
                          ),

                          Gap(20.h),

                          Text(
                            AppStrings.topPerformingContent.tr,
                            style: context.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Gap(12.h),

                          TopContentList(),
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
