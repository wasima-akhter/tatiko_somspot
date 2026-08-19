import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/language/controller/language_controller.dart';

import '../../../../../offers/shared/response/offers_response.dart';

class MerchantOfferMeta extends StatelessWidget {
  final OfferModel deal;

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
  final OfferModel deal;

  const MerchantOfferExpiry({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    final endAt = DateTime.parse(deal.endAt.toIso8601String());

    final isSomali =
        LanguageController.to.selectedLanguage.value == AppLanguage.somali;

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
                  inNextLine: isSomali ? true : false,
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
  final OfferModel deal;

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
