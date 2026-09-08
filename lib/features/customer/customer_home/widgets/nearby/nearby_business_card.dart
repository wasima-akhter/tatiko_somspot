import '../../../../../share/export/screen_export.dart';
import '../../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../core/business/response/business-response.dart';
import '../../../customer_business_details/controller/customer_business_details_controller.dart';

class NearbyBusinessCard extends StatelessWidget {
  final BusinessModel item;
  const NearbyBusinessCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (Get.isRegistered<CustomerBusinessDetailsController>()) {
          Get.delete<CustomerBusinessDetailsController>();
        }
        AppRouter.route.pushNamed(
          RoutePath.customerBusinessDetailsScreen,
          extra: item.id,
        );
      },
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
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.orangeSecondaryAccentColor,
                            size: 14.sp,
                          ),
                          Gap(4.w),
                          Text(
                            item.ratingAvg.toString(),
                            style: context.bodyMedium.copyWith(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.bold,
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

                  if ((item.category?.name ?? '').isNotEmpty) ...[
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
                        style: context.bodyMedium.copyWith(
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
                        style: context.bodyMedium.copyWith(
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
  }
}
