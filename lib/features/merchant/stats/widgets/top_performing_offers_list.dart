import 'package:som_spot/features/merchant/stats/controller/stats_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';

class TopPerformingOffersList extends GetView<StatsController> {
  const TopPerformingOffersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final offers = controller.topOffers;

      if (offers.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Text(
              AppStrings.noTopPerformingOffers.tr,
              style: context.bodyMedium.copyWith(
                color: AppColors.subtitleTextColor,
              ),
            ),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.topPerformingOffers.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),

          Gap(16.h),

          ...offers.map(
            (offer) => _buildItem(
              context: context,
              title: offer.title,
              business: offer.business?.name ?? "",
              discount: offer.discountLabel,
              claims: offer.totalClaims,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildItem({
    required BuildContext context,
    required String title,
    required String business,
    required String discount,
    required int claims,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.local_offer_outlined,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
          ),

          Gap(12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkTextColor,
                  ),
                ),

                Gap(4.h),

                Text(
                  "$business • $discount",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ),
          ),

          Gap(12.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$claims",
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                AppStrings.claims.tr,
                style: context.bodySmall.copyWith(
                  color: AppColors.subtitleTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
