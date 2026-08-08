import '../../../../share/controller/screen_export.dart';
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
              AppStrings.trendingNow.tr,
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
