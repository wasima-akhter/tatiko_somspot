import 'package:som_spot/features/customer/customer_home/controller/home_controller.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../share/widgets/ui_status_builder/error_card.dart';
import '../../customer_business_details/widgets/tab_modulars/offer_tab_content/merchant_offer_card.dart';

class HomeTopDealsWidget extends StatelessWidget {
  const HomeTopDealsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------------------------------------------------------------
        // Header
        // ---------------------------------------------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.topDeals.tr,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextColor,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                AppRouter.route.pushNamed(RoutePath.topDealsScreen);
              },
              child: Text(
                AppStrings.seeAll.tr,
                style: context.bodyMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        Gap(16.h),

        // ---------------------------------------------------------------------
        // Top Deals
        // ---------------------------------------------------------------------
        Obx(() {
          final paginator = controller.topDealsPaginator;

          return ApiStatusBuilder(
            status: paginator.status.value,
            errorMessage: paginator.errorMessage.value,
            onRetry: controller.loadTopDeals,
            noDataWidget: _TopDealsEmpty(onRetry: controller.loadTopDeals),
            builder: (_) {
              if (paginator.items.isEmpty) {
                return _TopDealsEmpty(onRetry: controller.loadTopDeals);
              }

              // Only show first 2 on Home
              final deals = paginator.items.take(2).toList();

              return Column(
                children: List.generate(deals.length, (index) {
                  final deal = deals[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == deals.length - 1 ? 0 : 16.h,
                    ),
                    child: MerchantOfferCard(deal: deal),
                  );
                }),
              );
            },
          );
        }),
      ],
    );
  }
}

class _TopDealsEmpty extends StatelessWidget {
  final VoidCallback onRetry;

  const _TopDealsEmpty({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.backgroundsLinesColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_offer_outlined,
              size: 22.sp,
              color: AppColors.primaryColor,
            ),
          ),

          Gap(12.h),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    AppStrings.noTopDealsYet.tr.capitalizeWords(),
                    textAlign: TextAlign.left,
                    style: context.bodyLarge.copyWith(height: 1.4),
                  ),
                ),

                Gap(14.h),

                RetryButton(onTap: onRetry),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
