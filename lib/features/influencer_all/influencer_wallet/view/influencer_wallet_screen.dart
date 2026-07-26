import 'package:som_spot/features/influencer_all/influencer_wallet/widgets/earnings_trend_chart.dart';

import '../../../../share/controller/screen_export.dart';
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
    return ScaffoldWrapper(
      backgroundColor: AppColors.softBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(12.h),

              Text(
                "Wallet",
                style: context.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
              ),

              Gap(18.h),

              const WalletBalanceCard(),

              Gap(14.h),

              Obx(
                () => controller.selectedTab.value == 0
                    ? ActiveTasks()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WalletFilterTabs(),

                          Gap(20.h),

                          Text(
                            "Performance",
                            style: context.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkTextColor,
                            ),
                          ),

                          Gap(18.h),

                          const PerformanceGrid(),

                          Gap(20.h),

                          EarningsTrendChart(),

                          Gap(20.h),

                          Text(
                            "Top Performing Content",
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
