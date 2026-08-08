import '../../../../share/controller/screen_export.dart';

class RecentSearches extends StatelessWidget {
  RecentSearches({super.key});

  final List<String> searches = [
    "Hilib Macaan",
    "Pharmacy near me",
    "Coffee shops",
    "Pizza",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Icon(Iconsax.clock, size: 16.sp, color: Colors.grey),

            Gap(6.w),

            Text(
              AppStrings.recentSearches.tr,
              style: context.titleSmall.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),

            Text(
              AppStrings.clear.tr,
              style: context.titleSmall.copyWith(
                color: AppColors.blueAccentColor,
              ),
            ),
          ],
        ),

        Gap(12.h),

        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,

          children: searches.map((item) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.grayTertiaryTextColor.withValues(alpha: 0.5),
                ),
              ),

              child: Text(
                item,
                style: context.titleSmall.copyWith(
                  color: AppColors.grayTextSecondaryColor,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
