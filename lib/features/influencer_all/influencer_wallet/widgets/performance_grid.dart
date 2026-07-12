import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

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
            title: "Total Views",
            value: "45K",
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCard(
            icon: Iconsax.magic_star,
            iconColor: Colors.purple,
            title: "Total Clicks",
            value: "3.2K",
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: StatCard(
            icon: Iconsax.tick_circle,
            iconColor: Colors.green,
            title: "Claims",
            value: "480",
          ),
        ),
      ],
    );
  }
}
