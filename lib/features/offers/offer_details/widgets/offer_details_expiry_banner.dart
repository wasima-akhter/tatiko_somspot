import '../../../../share/controller/screen_export.dart';

class OfferDetailsExpiryBanner extends StatelessWidget {
  final DateTime endDate;

  const OfferDetailsExpiryBanner({super.key, required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),

      decoration: BoxDecoration(
        color: AppColors.orangeColor.withValues(alpha: 0.05),

        borderRadius: BorderRadius.circular(8.r),
      ),

      child: Row(
        children: [
          Icon(Icons.access_time, color: AppColors.orangeColor, size: 18.sp),

          Gap(8.w),

          Text(
            '${AppStrings.expiresIn.tr} ${_remainingDays(endDate)}',

            style: context.bodyMedium.copyWith(
              color: AppColors.orangeColor,

              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _remainingDays(DateTime date) {
    final days = date.difference(DateTime.now()).inDays;

    if (days <= 0) {
      return 'Expired';
    }

    return '$days days';
  }
}
