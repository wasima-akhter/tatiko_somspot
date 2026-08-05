import 'package:som_spot/share/controller/screen_export.dart';

import '../../../merchant/dashboard_merchant/widgets/dashboard_stat_card.dart';
import '../response/influencer_dashboard_response.dart';

class InfluencerPerformanceGrid extends StatelessWidget {
  final InfluencerDashboardModel? data;
  final bool isLoading;

  const InfluencerPerformanceGrid({
    super.key,
    this.data,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DashboardStatCard(
            title: "Total Views",
            value: isLoading ? "0" : "0",
            icon: Iconsax.eye,
            iconColor: AppColors.blueAccentColor,
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: DashboardStatCard(
            title: "Total Clicks",
            value: isLoading ? "0" : "0",
            icon: Iconsax.magic_star,
            iconColor: AppColors.purpleAccentColor,
          ),
        ),

        SizedBox(width: 12.w),

        Expanded(
          child: DashboardStatCard(
            title: "Claims",
            value: isLoading ? "0" : "${data?.claims ?? 0}",
            icon: Iconsax.tick_circle,
            iconColor: AppColors.emeraldGreenColor,
          ),
        ),
      ],
    );
  }
}
