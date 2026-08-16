import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../shared/model/deal_model.dart';

class MerchantOfferMeta extends StatelessWidget {
  final DealModel deal;

  const MerchantOfferMeta({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MerchantOfferExpiry(deal: deal),
        const Spacer(),
        MerchantOfferClaimStatus(deal: deal),
      ],
    );
  }
}

class MerchantOfferExpiry extends StatelessWidget {
  final DealModel deal;

  const MerchantOfferExpiry({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    final endAt = DateTime.parse(deal.endAt);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_busy_outlined,
            color: AppColors.warning,
            size: 12.sp,
          ),
          Gap(4.w),
          Text(
            DateConverter().remainingTime(endAt) ??
                DateConverter.formatDateTime(
                  dateTime: endAt,
                  showExpired: true,
                ),
            style: context.bodySmall.copyWith(
              color: AppColors.warning,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class MerchantOfferClaimStatus extends StatelessWidget {
  final DealModel deal;

  const MerchantOfferClaimStatus({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        deal.isClaimed == false ? AppStrings.claim.tr : AppStrings.claimed.tr,
        style: context.bodySmall.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
