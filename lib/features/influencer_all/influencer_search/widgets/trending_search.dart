import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/extension/base_extension.dart';
import 'trending_search_card.dart';

class TrendingSearch extends StatelessWidget {
  TrendingSearch({super.key});

  final List<String> businesses = [
    "Liido Beach Cafe",
    "Banadir Pharmacy",
    "Hayat Supermarket",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Icon(Iconsax.trend_up, size: 16.sp, color: Colors.grey),

            Gap(6.w),

            Text(
              "Trending Now",
              style: context.titleSmall.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),

        Gap(12.h),

        Column(
          children: businesses
              .map((item) => TrendingSearchCard(title: item))
              .toList(),
        ),
      ],
    );
  }
}
