// -----------------------------------------------------------------------------
// 4. Saved Businesses List Widget
// -----------------------------------------------------------------------------
import 'package:som_spot/features/customer/saved/controller/saved_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../shared/response/saved_business_model.dart';

class SavedBusinessesListWidget extends GetView<SavedScreenController> {
  const SavedBusinessesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.businessPaginator.status.value,
        errorMessage: controller.businessPaginator.errorMessage.value,
        onRetry: controller.loadBusinesses,
        isLoadingMore:
            controller.businessPaginator.loadMoreStatus.value ==
            ApiStatus.loading,
        hasMore: controller.businessPaginator.hasMore.value,
        builder: (_) {
          return CustomRefreshIndicator(
            onRefresh: controller.refreshBusinesses,
            child: ListView.separated(
              controller: controller.listScrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: controller.businessPaginator.items.length,
              separatorBuilder: (_, index) => Gap(16.h),
              itemBuilder: (context, index) {
                final saved = controller.businessPaginator.items[index];
                final business = saved.business;

                if (business == null) {
                  return const SizedBox.shrink();
                }

                return SavedBusinessesInfoCard(business: business);
              },
            ),
          );
        },
      ),
    );
  }
}

class SavedBusinessesInfoCard extends StatelessWidget {
  final SavedBusinessInfo business;
  const SavedBusinessesInfoCard({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: CustomNetworkImage(
                  imageUrl: business.logo,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.orangeSecondaryAccentColor,
                        size: 14.sp,
                      ),
                      Gap(4.w),
                      Text(
                        business.ratingAvg.toStringAsFixed(1),
                        style: context.bodyMedium.copyWith(
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
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  business.name,
                  style: context.titleMedium.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Gap(4.h),
                Text(
                  business.address,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                    fontSize: 13.sp,
                  ),
                ),
                Gap(12.h),
                Row(
                  children: [
                    Icon(
                      Iconsax.location,
                      color: AppColors.primaryColor,
                      size: 16.sp,
                    ),
                    Gap(4.w),
                    Expanded(
                      child: Text(
                        business.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.bodyMedium.copyWith(
                          color: AppColors.subtitleTextColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
