import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../response/dashboard_merchant_response.dart';

class TopDealsList extends StatelessWidget {
  final List<TopDeal> deals;
  final bool isLoading;

  const TopDealsList({super.key, required this.deals, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (!isLoading && deals.isEmpty) {
      return const EmptyTopDeals();
    }

    return Column(
      children: List.generate(deals.length, (index) {
        final deal = deals[index];

        return Column(
          children: [
            _buildTopDealItem(
              context: context,
              title: deal.title,
              businessName: deal.businessName,
              totalClaims: deal.totalClaims,
              percentage: deal.discountLabel,
              percentageColor: AppColors.emeraldGreenColor,
              isLoading: isLoading,
            ),

            if (index != deals.length - 1) Gap(12.h),
          ],
        );
      }),
    );
  }

  Widget _buildTopDealItem({
    required BuildContext context,
    required String title,
    required String businessName,
    required int totalClaims,
    required String percentage,
    required Color percentageColor,
    required bool isLoading,
  }) {
    final subtitle = businessName.isEmpty
        ? AppStrings.topDealsLoadingBusiness.tr
        : '$businessName • ${AppStrings.topDealsClaims.trParams({'count': totalClaims.toString()})}';

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          AutoShimmerAnimate(
            isLoading: isLoading,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: AppColors.softSlateBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.tag,
                color: AppColors.slateIconColor,
                size: 20.sp,
              ),
            ),
          ),

          Gap(12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoShimmerAnimate(
                  isLoading: isLoading,
                  child: Text(
                    title.isEmpty
                        ? AppStrings.topDealsLoadingTitle.tr
                        : title.capitalizeWords(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                ),

                Gap(4.h),

                AutoShimmerAnimate(
                  isLoading: isLoading,
                  child: Text(
                    subtitle.isEmpty
                        ? '${AppStrings.topDealsLoadingBusiness.tr} • '
                              '${AppStrings.topDealsClaims.trParams({'count': '0'})}'
                        : subtitle.capitalizeWords(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Gap(8.w),

          AutoShimmerAnimate(
            isLoading: isLoading,
            child: Text(
              percentage.isEmpty
                  ? AppStrings.topDealsPercentageFallback.tr
                  : percentage,
              style: context.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: percentageColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyTopDeals extends StatelessWidget {
  const EmptyTopDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: AppColors.softSlateBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.tag,
              size: 24.sp,
              color: AppColors.slateIconColor,
            ),
          ),

          Gap(12.h),

          Text(
            AppStrings.topDealsEmptyTitle.tr,
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextColor,
            ),
          ),

          Gap(4.h),

          Text(
            AppStrings.topDealsEmptyDescription.tr,
            textAlign: TextAlign.center,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
