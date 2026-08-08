import 'package:som_spot/share/controller/screen_export.dart';

import 'stat_card.dart';

class PerformanceGrid extends StatelessWidget {
  const PerformanceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            icon: Iconsax.eye,
            iconColor: Colors.blue,
            title: AppStrings.totalViews.tr,
            value: "45K",
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCard(
            icon: Iconsax.magic_star,
            iconColor: Colors.purple,
            title: AppStrings.totalClicks.tr,
            value: "3.2K",
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCard(
            icon: Iconsax.tick_circle,
            iconColor: Colors.green,
            title: AppStrings.claims.tr,
            value: "480",
          ),
        ),
      ],
    );
  }
}
