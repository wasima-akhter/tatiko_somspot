import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/features/customer/saved/controller/saved_controller.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../share/controller/screen_export.dart';

class SavedScreen extends GetView<SavedScreenController> {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.white),
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Column(
          children: [
            // White Header Container with Tab Switcher
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.saved.tr,
                    style: context.titleLarge.copyWith(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),
                  Gap(16.h),
                  // Capsule Tab Selector
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.all(4.w),
                    child: Obx(() {
                      final selectedIndex = controller.rxSelectedTab.value;
                      return Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectTab(0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedIndex == 0
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: selectedIndex == 0
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.04,
                                            ),
                                            blurRadius: 4.r,
                                            offset: Offset(0, 2.h),
                                          ),
                                        ]
                                      : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.businesses.tr,
                                  style: context.bodyMedium.copyWith(
                                    color: selectedIndex == 0
                                        ? AppColors.primaryColor
                                        : AppColors.subtitleTextColor,
                                    fontWeight: selectedIndex == 0
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => controller.selectTab(1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: selectedIndex == 1
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.04,
                                            ),
                                            blurRadius: 4.r,
                                            offset: Offset(0, 2.h),
                                          ),
                                        ]
                                      : null,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.offers.tr,
                                  style: context.bodyMedium.copyWith(
                                    color: selectedIndex == 1
                                        ? AppColors.primaryColor
                                        : AppColors.subtitleTextColor,
                                    fontWeight: selectedIndex == 1
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: Container(
                width: double.infinity,
                color: AppColors.primaryColor.withValues(alpha: 0.05),
                child: Obx(() {
                  final isBusinesses = controller.rxSelectedTab.value == 0;
                  final isLoading = controller.rxIsLoading.value;

                  return AutoShimmerAnimate(
                    isLoading: isLoading,
                    child: isBusinesses
                        ? _buildBusinessesList(controller, context)
                        : _buildOffersList(controller, context),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessesList(
    SavedScreenController controller,
    BuildContext context,
  ) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: controller.rxSavedBusinesses.length,
      separatorBuilder: (context, index) => Gap(16.h),
      itemBuilder: (context, index) {
        final business = controller.rxSavedBusinesses[index];
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
              // Image container with rating
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: business.imageUrl,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
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
                            business.rating.toString(),
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
              // Details
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
                      business.category,
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
                        Text(
                          business.distance,
                          style: context.bodyMedium.copyWith(
                            color: AppColors.subtitleTextColor,
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: business.isOpen
                                    ? AppColors.success
                                    : AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Gap(6.w),
                            Text(
                              business.isOpen
                                  ? AppStrings.openNow.tr
                                  : AppStrings.closed.tr,
                              style: context.bodyMedium.copyWith(
                                color: business.isOpen
                                    ? AppColors.success
                                    : AppColors.error,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOffersList(
    SavedScreenController controller,
    BuildContext context,
  ) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: controller.rxSavedOffers.length,
      separatorBuilder: (context, index) => Gap(12.h),
      itemBuilder: (context, index) {
        final offer = controller.rxSavedOffers[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              // Image with tag on top
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CustomNetworkImage(
                      imageUrl: offer.imageUrl,
                      height: 90.h,
                      width: 90.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6.h,
                    left: 6.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.orangeSecondaryAccentColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 3.h,
                      ),
                      child: Text(
                        offer.tag,
                        style: context.bodyMedium.copyWith(
                          color: AppColors.darkTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(12.w),
              // Offer Details on the right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.businessName,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      offer.title,
                      style: context.titleMedium.copyWith(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // TimeLeft badge
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.warning.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.clock,
                                color: AppColors.warning,
                                size: 12.sp,
                              ),
                              Gap(4.w),
                              Text(
                                offer.timeLeft,
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Claim button
                        Obx(() {
                          final claimed = offer.isClaimed.value;
                          return GestureDetector(
                            onTap: () => controller.toggleClaim(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: claimed
                                    ? AppColors.success.withValues(alpha: 0.1)
                                    : AppColors.primaryColor.withValues(
                                        alpha: 0.12,
                                      ),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: claimed
                                      ? AppColors.success
                                      : AppColors.primaryColor,
                                  width: 1.w,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              child: Text(
                                claimed
                                    ? AppStrings.claimed.tr
                                    : AppStrings.claim.tr,
                                style: context.bodyMedium.copyWith(
                                  color: claimed
                                      ? AppColors.success
                                      : AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
