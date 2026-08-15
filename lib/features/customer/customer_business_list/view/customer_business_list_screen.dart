import 'package:som_spot/features/customer/customer_business_list/controller/customer_business_list_controller.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../share/controller/screen_export.dart';

class CustomerBusinessListScreen
    extends GetView<CustomerBusinessListController> {
  const CustomerBusinessListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: controller.categoryInfo?.categoryName ?? AppStrings.business.tr,
      body: SafeArea(
        child: Obx(
          () => ApiStatusBuilder(
            status: controller.businessListPaginator.status.value,
            errorMessage: controller.categoryInfo == null
                ? "No businesses found under this category."
                : controller.businessListPaginator.errorMessage.value,
            onRetry: () => controller.businessListPaginator.refresh(),
            isLoadingMore:
                controller.businessListPaginator.loadMoreStatus.value ==
                ApiStatus.loading,
            hasMore: controller.businessListPaginator.hasMore.value,
            builder: (_) {
              return RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () => controller.refreshBusinesses(),
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: controller.businessListScrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  itemCount: controller.businesses.length,
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) {
                    final item = controller.businesses[index];
                    return GestureDetector(
                      onTap: () => AppRouter.route.pushNamed(
                        RoutePath.customerBusinessDetailsScreen,
                        extra: item.id,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 12.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Part
                            SizedBox(
                              height: 180.h,
                              width: double.infinity,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r),
                                    ),
                                    child: CustomNetworkImage(
                                      imageUrl: item.logo ?? "",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Star Rating Badge
                                  // if (item.rating != null)
                                  Positioned(
                                    top: 12.h,
                                    right: 12.w,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.05,
                                            ),
                                            blurRadius: 4.r,
                                            offset: Offset(0, 2.h),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: AppColors
                                                .orangeSecondaryAccentColor,
                                            size: 14.sp,
                                          ),
                                          Gap(4.w),
                                          Text(
                                            item.ratingAvg.toString(),

                                            style: context.bodySmall.copyWith(
                                              color: AppColors.darkTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Information Part
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name ?? "",
                                    style: context.titleMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkTextColor,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  if ((item.category?.name ?? '')
                                      .isNotEmpty) ...[
                                    Gap(4.h),
                                    Text(
                                      item.category?.name ?? "",
                                      style: context.bodyMedium.copyWith(
                                        color: AppColors.subtitleTextColor,
                                      ),
                                    ),
                                  ],
                                  Gap(12.h),
                                  Row(
                                    children: [
                                      // Distance
                                      Icon(
                                        Icons.location_on,
                                        color: AppColors.primaryColor,
                                        size: 16.sp,
                                      ),
                                      Gap(4.w),
                                      Text(
                                        "${item.distanceKm} km",
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.subtitleTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Gap(16.w),
                                      // Open/Closed Status
                                      Icon(
                                        Icons.access_time,
                                        color: (item.isOpen == true)
                                            ? AppColors.subtitleTextColor
                                            : AppColors.error,
                                        size: 16.sp,
                                      ),
                                      Gap(4.w),
                                      Text(
                                        (item.isOpen == true)
                                            ? AppStrings.openNow.tr
                                            : AppStrings.closed.tr,
                                        style: context.bodySmall.copyWith(
                                          color: (item.isOpen == true)
                                              ? AppColors.subtitleTextColor
                                              : AppColors.error,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
