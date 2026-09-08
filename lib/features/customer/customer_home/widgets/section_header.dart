import '../../../../share/export/screen_export.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkTextColor,
          ),
        ),

        // GestureDetector(
        //   behavior: HitTestBehavior.opaque,
        //   onTap: onSeeAll,
        //   child: Text(
        //     AppStrings.seeAll.tr,
        //     style: context.bodyMedium.copyWith(
        //       color: AppColors.primaryColor,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
