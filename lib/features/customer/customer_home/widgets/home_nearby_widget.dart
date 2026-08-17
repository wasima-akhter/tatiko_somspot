import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../controller/home_controller.dart';

class HomeNearbyWidget extends StatefulWidget {
  const HomeNearbyWidget({super.key});

  @override
  State<HomeNearbyWidget> createState() => _HomeNearbyWidgetState();
}

class _HomeNearbyWidgetState extends State<HomeNearbyWidget> {
  final controller = HomeController.to;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.refreshNearbyBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.nearbyYou.tr,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextColor,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => AppRouter.route.pushNamed(
                RoutePath.customerBusinessListScreen,
              ),
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

        Obx(
          () => ApiStatusBuilder(
            status: controller.nearbyBusinessesPaginator.status.value,
            errorMessage:
                controller.nearbyBusinessesPaginator.errorMessage.value,
            noDataWidget: HomeEmptyState(
              icon: Icons.location_off_outlined,
              title: AppStrings.noNearbyPlacesYet.tr,
              message: AppStrings.noNearbyPlacesMessage.tr,
              onRetry: controller.loadNearbyBusinesses,
            ),
            onRetry: controller.loadNearbyBusinesses,
            isLoadingMore:
                controller.nearbyBusinessesPaginator.loadMoreStatus.value ==
                ApiStatus.loading,
            hasMore: controller.nearbyBusinessesPaginator.hasMore.value,
            builder: (_) {
              if (controller.nearbyBusinessesPaginator.items.isEmpty) {
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
                      AppStrings.noNearbyMerchantsFound.tr,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.subtitleTextColor,
                      ),
                    ),
                  ),
                );
              }

              return CustomRefreshIndicator(
                onRefresh: controller.refreshNearbyBusinesses,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: controller.nearbyBusinessesScrollController,
                  itemCount: controller.nearbyBusinesses.length,
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) {
                    final item = controller.nearbyBusinesses[index];

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
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
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10.r,
                              offset: Offset(0, 4.h),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Part
                            SizedBox(
                              height: 150.h,
                              width: double.infinity,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16.r),
                                    ),
                                    child: CustomNetworkImage(
                                      imageUrl: item.coverImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // Star Rating Badge
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
                                    item.name,
                                    style: context.titleLarge.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkTextColor,
                                    ),
                                  ),

                                  if ((item.category?.name ?? '')
                                      .isNotEmpty) ...[
                                    Gap(4.h),
                                    Text(
                                      item.category?.name ?? '',
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
                                        item.distanceLabel,
                                        style: context.bodySmall.copyWith(
                                          color: AppColors.subtitleTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Gap(16.w),

                                      // Open/Closed Status
                                      Icon(
                                        Icons.access_time_filled,
                                        color: item.isOpen
                                            ? AppColors.success
                                            : AppColors.error,
                                        size: 16.sp,
                                      ),
                                      Gap(4.w),
                                      Text(
                                        item.isOpen
                                            ? AppStrings.openNow.tr
                                            : AppStrings.closed.tr,
                                        style: context.bodySmall.copyWith(
                                          color: item.isOpen
                                              ? AppColors.success
                                              : AppColors.error,
                                          fontWeight: FontWeight.bold,
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
      ],
    );
  }
}

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.icon = Icons.search_off_rounded,
  });

  final String title;
  final String message;
  final VoidCallback onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 23.sp),
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
                  style: context.bodyMedium.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(3.h),
                Text(
                  message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                    height: 1.3,
                  ),
                ),
                Gap(8.h),
                SizedBox(
                  height: 30.h,
                  child: TextButton.icon(
                    onPressed: onRetry,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      foregroundColor: AppColors.primaryColor,
                    ),
                    icon: Icon(Icons.refresh_rounded, size: 14.sp),
                    label: Text(
                      AppStrings.tryAgain.tr,
                      style: context.bodySmall.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
