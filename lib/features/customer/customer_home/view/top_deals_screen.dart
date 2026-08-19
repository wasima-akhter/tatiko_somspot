import 'package:som_spot/features/customer/customer_home/controller/home_controller.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/refresh_indicator/refresh_indicator.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../customer_business_details/widgets/tab_modulars/offer_tab_content/merchant_offer_card.dart';

class TopDealsScreen extends StatefulWidget {
  const TopDealsScreen({super.key});

  @override
  State<TopDealsScreen> createState() => _TopDealsScreenState();
}

class _TopDealsScreenState extends State<TopDealsScreen> {
  final controller = HomeController.to;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only fetch if there is no data yet.
      if (controller.topDealsPaginator.items.isEmpty) {
        controller.loadTopDeals();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          AppStrings.topDeals.tr,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.darkTextColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => ApiStatusBuilder(
            status: controller.topDealsPaginator.status.value,
            errorMessage: controller.topDealsPaginator.errorMessage.value,
            onRetry: controller.loadTopDeals,
            isLoadingMore:
                controller.topDealsPaginator.loadMoreStatus.value ==
                ApiStatus.loading,
            hasMore: controller.topDealsPaginator.hasMore.value,
            noDataWidget: _EmptyTopDeals(onRetry: controller.loadTopDeals),
            builder: (_) {
              if (controller.topDeals.isEmpty) {
                return _EmptyTopDeals(onRetry: controller.loadTopDeals);
              }

              return CustomRefreshIndicator(
                onRefresh: controller.refreshTopDeals,
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: controller.topDealsScrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.all(16.w),

                  // +1 for loading-more indicator
                  itemCount:
                      controller.topDeals.length +
                      (controller.topDealsPaginator.loadMoreStatus.value ==
                              ApiStatus.loading
                          ? 1
                          : 0),

                  separatorBuilder: (_, _) => Gap(16.h),

                  itemBuilder: (context, index) {
                    // ── Loading more indicator ──
                    if (index == controller.topDeals.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(child: LoadingWidget()),
                      );
                    }

                    final deal = controller.topDeals[index];

                    return MerchantOfferCard(deal: deal);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EmptyTopDeals extends StatelessWidget {
  const _EmptyTopDeals({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.local_offer_outlined,
                color: AppColors.primaryColor,
                size: 30.sp,
              ),
            ),
            Gap(16.h),
            Text(
              AppStrings.noTopDealsYet.tr,
              textAlign: TextAlign.center,
              style: context.titleMedium.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(6.h),
            Text(
              AppStrings.noTopDealsMessage.tr,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                color: AppColors.subtitleTextColor,
              ),
            ),
            Gap(12.h),
            TextButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh_rounded, size: 16.sp),
              label: Text(AppStrings.tryAgain.tr),
            ),
          ],
        ),
      ),
    );
  }
}
