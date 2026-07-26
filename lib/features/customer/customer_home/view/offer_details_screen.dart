import 'package:som_spot/features/customer/customer_home/controller/home_nearby_controller.dart';
import 'package:som_spot/features/customer/customer_home/model/deal_model.dart';
import 'package:som_spot/features/customer/customer_home/model/merchant_model.dart';
import 'package:som_spot/share/widgets/dialog/custom_dialog.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../share/controller/screen_export.dart';

class OfferDetailsScreen extends StatelessWidget {
  final DealModel deal;

  const OfferDetailsScreen({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          AppStrings.offerDetails.tr,
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
        child: Stack(
          children: [
            // Scrollable Content
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Offer Details Card
                    Container(
                      width: double.infinity,
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
                          // Image with share/fav overlay
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
                                    imageUrl: deal.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Star badge
                                Positioned(
                                  top: 12.h,
                                  left: 12.w,
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
                                          "4.8",
                                          style: context.bodySmall.copyWith(
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
                          Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Merchant Name Link
                                GestureDetector(
                                  onTap: () => _navigateToMerchantDetails(
                                    context,
                                    deal.merchantName,
                                  ),
                                  child: Text(
                                    deal.merchantName,
                                    style: context.bodyMedium.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Gap(8.h),
                                // Offer Title
                                Text(
                                  deal.title,
                                  style: context.headlineSmall.copyWith(
                                    color: AppColors.darkTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(12.h),
                                // Description Text
                                Text(
                                  "Get 20% off our signature family platter featuring roasted goat, rice, and fresh salad.",
                                  style: context.bodyMedium.copyWith(
                                    color: AppColors.subtitleTextColor,
                                    height: 1.5,
                                  ),
                                ),
                                Gap(16.h),
                                // Countdown timer
                                Container(
                                  padding: EdgeInsets.all(12.r),
                                  decoration: BoxDecoration(
                                    color: AppColors.warning.withValues(
                                      alpha: 0.08,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_filled,
                                        color: AppColors.warning,
                                        size: 18.sp,
                                      ),
                                      Gap(8.w),
                                      Text(
                                        "Expires in ${deal.timeLeft}",
                                        style: context.bodyMedium.copyWith(
                                          color: AppColors.warning,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(24.h),

                    // Terms and conditions
                    Text(
                      AppStrings.termsConditions.tr,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Gap(12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.backgroundsLinesColor,
                        ),
                      ),
                      child: Text(
                        AppStrings.termsText.tr,
                        style: context.bodyMedium.copyWith(
                          color: AppColors.subtitleTextColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Sticky Bottom Claim Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: const Border(
                    top: BorderSide(color: AppColors.backgroundsLinesColor),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10.r,
                      offset: Offset(0, -4.h),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context: context,
                        title: AppStrings.offerClaimedTitle.tr,
                        subtitle: AppStrings.offerClaimedSuccess.tr,
                        type: AppDialogType.success,
                        showDefaultButtons: true,
                        confirmText: "OK",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      AppStrings.claimOfferNow.tr,
                      style: context.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMerchantDetails(BuildContext context, String merchantName) {
    // Try to find the merchant in nearby merchants list
    try {
      final nearbyController = Get.find<HomeNearbyController>();
      final merchant = nearbyController.merchants.firstWhereOrNull(
        (element) => element.title.toLowerCase() == merchantName.toLowerCase(),
      );

      if (merchant != null) {
        AppRouter.route.pushNamed(
          RoutePath.merchantDetailsScreen,
          extra: merchant,
        );
        return;
      }
    } catch (_) {}

    // Fallback MerchantModel
    final fallbackMerchant = MerchantModel(
      id: 'fallback_${merchantName.hashCode}',
      imageUrl:
          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop',
      title: merchantName,
      category: 'Restaurant',
      distance: '1.2 km',
      isOpen: true,
      rating: '4.8',
    );
    AppRouter.route.pushNamed(
      RoutePath.merchantDetailsScreen,
      extra: fallbackMerchant,
    );
  }
}
