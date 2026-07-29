import '../../../../helper/date_converter/date_converter.dart';
import '../../../../share/controller/screen_export.dart';

class OfferDetailsDateRow extends StatelessWidget {
  final String title;

  final DateTime date;

  final Color iconColor;

  const OfferDetailsDateRow({
    super.key,

    required this.title,

    required this.date,

    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: context.bodySmall.copyWith(color: AppColors.hintTextColor),
        ),

        Gap(4.h),

        Row(
          children: [
            Icon(Iconsax.calendar_1, size: 16.sp, color: iconColor),

            Gap(6.w),

            Text(
              DateConverter.formatDate(dateTime: date),

              style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,

                color: AppColors.darkTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
