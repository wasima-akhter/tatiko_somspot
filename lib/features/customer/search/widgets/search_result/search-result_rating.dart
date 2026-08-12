import '../../../../../share/controller/screen_export.dart';

class SearchResultRating extends StatelessWidget {
  const SearchResultRating({
    super.key,
    required this.rating,
    required this.ratingCount,
  });
  final double rating;
  final int ratingCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: AppColors.orangeSecondaryAccentColor,
          size: 15.sp,
        ),
        Gap(4.w),
        Text(
          rating.toStringAsFixed(1),
          style: context.bodySmall.copyWith(
            color: AppColors.darkTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(5.w),
        Text(
          "($ratingCount)",
          style: context.bodySmall.copyWith(color: AppColors.hintTextColor),
        ),
      ],
    );
  }
}
