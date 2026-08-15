import 'package:som_spot/share/controller/screen_export.dart';

class MerchantReviewStars extends StatelessWidget {
  const MerchantReviewStars({
    super.key,
    required this.rating,
    required this.size,
  });

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starNumber = index + 1;

        IconData icon;

        if (rating >= starNumber) {
          icon = Icons.star_rounded;
        } else if (rating >= starNumber - 0.5) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_border_rounded;
        }

        return Icon(
          icon,
          color: AppColors.orangeSecondaryAccentColor,
          size: size,
        );
      }),
    );
  }
}
