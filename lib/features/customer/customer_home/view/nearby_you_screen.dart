import 'package:som_spot/features/customer/customer_home/controller/home_nearby_controller.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../share/controller/screen_export.dart';

class NearbyYouScreen extends StatelessWidget {
  const NearbyYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeNearbyController>();

    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          AppStrings.nearbyYou.tr,
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
        child: Obx(() {
          if (controller.isLoading.value && controller.merchants.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (controller.merchants.isEmpty) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () => controller.fetchNearbyMerchants(isRefresh: true),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: context.screenHeight * 0.7,
                    child: Center(
                      child: Text(
                        "No nearby merchants found",
                        style: context.bodyMedium.copyWith(
                          color: AppColors.subtitleTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () => controller.fetchNearbyMerchants(isRefresh: true),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              itemCount: controller.merchants.length,
              separatorBuilder: (context, index) => Gap(16.h),
              itemBuilder: (context, index) {
                final item = controller.merchants[index];
                return GestureDetector(
                  onTap: () => AppRouter.route.pushNamed(
                    RoutePath.merchantDetailsScreen,
                    extra: item,
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
                                  imageUrl: item.imageUrl,
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
                                        color: AppColors
                                            .orangeSecondaryAccentColor,
                                        size: 14.sp,
                                      ),
                                      Gap(4.w),
                                      Text(
                                        item.rating,
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
                                item.title,
                                style: context.titleLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkTextColor,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                item.category,
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.subtitleTextColor,
                                ),
                              ),
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
                                    item.distance,
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
        }),
      ),
    );
  }
}
