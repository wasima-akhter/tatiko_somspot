import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/merchant_listing_controller.dart';
import 'manage_business_sheets.dart';

class ListingBusinessCard extends GetView<MerchantListingController> {
  const ListingBusinessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final business = controller.selectedBusiness.value;

      if (business == null) {
        return const SizedBox.shrink();
      }
      return Obx(
        () => ApiStatusBuilder(
          status:
              controller.businessController.myBusinessesPaginator.status.value,

          errorMessage: controller
              .businessController
              .myBusinessesPaginator
              .errorMessage
              .value,

          onRetry: controller.refreshData,

          // Only shimmer the texts
          loadingWidget: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                      child: Container(
                        height: 140.h,
                        width: double.infinity,
                        color: AppColors.grayTabBgColor,
                      ),
                    ),

                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          color: AppColors.blueAccentColor,
                          size: 18.sp,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -30.h,
                      left: 16.w,
                      child: Container(
                        width: 64.w,
                        height: 64.w,
                        decoration: BoxDecoration(
                          color: AppColors.grayTabBgColor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Gap(40.h),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoShimmerAnimate(
                        isLoading: true,
                        baseColor: AppColors.grayTabBgColor,
                        child: Container(
                          height: 20.h,
                          width: 180.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),

                      Gap(8.h),

                      AutoShimmerAnimate(
                        baseColor: AppColors.grayTabBgColor,
                        isLoading: true,
                        child: Container(
                          height: 14.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),

                      Gap(6.h),

                      AutoShimmerAnimate(
                        isLoading: true,
                        baseColor: AppColors.grayTabBgColor,
                        child: Container(
                          height: 14.h,
                          width: 220.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),

                      Gap(8.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Image
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                        child: CustomNetworkImage(
                          imageUrl: business.coverImage, // <-- cover image
                          height: 140.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: GestureDetector(
                          onTap: () {
                            showEditBusinessProfileSheet(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit_outlined,
                              color: AppColors.blueAccentColor,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: -30.h,
                        left: 16.w,
                        child: Container(
                          width: 64.w,
                          height: 64.w,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.white,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CustomNetworkImage(
                              imageUrl: business.logo, // <-- logo image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(40.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          business.name.capitalizeWords(),
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                          ),
                        ),

                        Gap(6.h),

                        Text(
                          business.description.capitalizeFirst ?? '',
                          style: context.bodyMedium.copyWith(
                            color: AppColors.subtitleTextColor,
                          ),
                        ),

                        Gap(8.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
