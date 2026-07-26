import 'package:som_spot/features/customer/customer_home/controller/merchant_details_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

class MerchantOffersTab extends StatelessWidget {
  final MerchantDetailsController controller;

  const MerchantOffersTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.merchantOffers.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(24.r),
        child: Center(
          child: Text(
            AppStrings.noActiveOffers.tr,
            style: context.bodyMedium.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: controller.merchantOffers.length,
      itemBuilder: (context, index) {
        final deal = controller.merchantOffers[index];
        return GestureDetector(
          onTap: () => AppRouter.route.pushNamed(
            RoutePath.offerDetailsScreen,
            extra: deal,
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h),
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
              child: Row(
                children: [
                  // Image
                  SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            bottomLeft: Radius.circular(16.r),
                          ),
                          child: CustomNetworkImage(
                            imageUrl: deal.imageUrl,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Discount Tag
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
                  // Offer Info
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal.title,
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
                                size: 12.sp,
                              ),
                              Gap(4.w),
                              Text(
                                deal.timeLeft,
                                style: context.bodySmall.copyWith(
                                  color: AppColors.warning,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  AppStrings.claim.tr,
                                  style: context.bodySmall.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
      },
    );
  }
}
