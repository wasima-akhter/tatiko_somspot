import 'package:som_spot/features/customer/customer_home/controller/home_deals_controller.dart';
import 'package:som_spot/features/customer/customer_home/widgets/home_shimmer_widgets.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

class HomeTopDealsWidget extends StatelessWidget {
  const HomeTopDealsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeDealsController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              onTap: () => AppRouter.route.pushNamed(RoutePath.topDealsScreen),
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
        Obx(() {
          if (controller.isLoading.value) {
            return const TopDealShimmer();
          }

          if (controller.topDeals.isEmpty) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "No top deals available",
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ),
            );
          }

          return Column(
            children: List.generate(controller.topDeals.length, (index) {
              final deal = controller.topDeals[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == controller.topDeals.length - 1 ? 0 : 16.h,
                ),
                child: GestureDetector(
                  onTap: () => AppRouter.route.pushNamed(
                    RoutePath.offerDetailsScreen,
                    extra: deal,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Image with Discount Tag
                        SizedBox(
                          width: 110.w,
                          height: 110.h,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.r),
                                  bottomLeft: Radius.circular(16.r),
                                ),
                                child: CustomNetworkImage(
                                  imageUrl: deal.imageUrl,
                                  width: 110.w,
                                  height: 110.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                left: 8.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.orangeSecondaryAccentColor,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    deal.discount,
                                    style: context.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(12.w),
                        // Content Part
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  deal.merchantName,
                                  style: context.bodyMedium.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(4.h),
                                Text(
                                  deal.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.titleMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkTextColor,
                                  ),
                                ),
                                Gap(8.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: AppColors.warning,
                                      size: 14.sp,
                                    ),
                                    Gap(4.w),
                                    Text(
                                      deal.timeLeft,
                                      style: context.bodySmall.copyWith(
                                        color: AppColors.warning,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppStrings.claim.tr,
                                          style: context.bodySmall.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(8.w),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}
