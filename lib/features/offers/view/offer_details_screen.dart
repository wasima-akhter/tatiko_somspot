import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/customer/home/model/deal_model.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../../../share/widgets/network_image/custom_network_image.dart';

class ClaimedOfferDetailsScreen extends StatelessWidget {
  final DealModel deal;
  const ClaimedOfferDetailsScreen({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.darkTextColor,
            size: 20.sp,
          ),
        ),
        title: Text(
          AppStrings.offerDetails.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.darkTextColor,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            // ── Cover Image & Primary Info Card ──
            Container(
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
                  // Cover Image with Badges
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                        child: CustomNetworkImage(
                          imageUrl:
                              'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop',
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 12.h,
                        left: 12.w,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6.w,
                                    height: 6.w,
                                    decoration: const BoxDecoration(
                                      color: AppColors.emeraldGreenColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Gap(6.w),
                                  Text(
                                    AppStrings.active.tr,
                                    style: context.bodySmall.copyWith(
                                      color: AppColors.emeraldGreenColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.amberYellowColor,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '20%',
                                style: context.bodySmall.copyWith(
                                  color: AppColors.darkTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Text Content
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hilib Macaan Restaurant',
                          style: context.bodyMedium.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(8.h),
                        Text(
                          '20% Off Family Platter',
                          style: context.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                          ),
                        ),
                        Gap(12.h),
                        Text(
                          'Get 20% off our signature family platter featuring roasted goat, rice, and fresh salad.',
                          style: context.bodyMedium.copyWith(
                            color: AppColors.subtitleTextColor,
                            height: 1.5,
                          ),
                        ),
                        Gap(16.h),

                        // Expiry Banner
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orangeColor.withValues(
                              alpha: 0.05,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: AppColors.orangeColor,
                                size: 18.sp,
                              ),
                              Gap(8.w),
                              Text(
                                '${AppStrings.expiresIn.tr} 2 days',
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.orangeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(16.h),

                        // Start & End Dates
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.starts.tr,
                                    style: context.bodySmall.copyWith(
                                      color: AppColors.hintTextColor,
                                    ),
                                  ),
                                  Gap(4.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.calendar_1,
                                        size: 16.sp,
                                        color: AppColors.blueAccentColor,
                                      ),
                                      Gap(6.w),
                                      Text(
                                        'Apr 12, 2026',
                                        style: context.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.ends.tr,
                                    style: context.bodySmall.copyWith(
                                      color: AppColors.hintTextColor,
                                    ),
                                  ),
                                  Gap(4.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Iconsax.calendar_1,
                                        size: 16.sp,
                                        color: AppColors.orangeColor,
                                      ),
                                      Gap(6.w),
                                      Text(
                                        'Apr 18, 2026',
                                        style: context.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
            Gap(16.h),

            // ── Terms & Conditions Card ──
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.termsAndConditions.tr,
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    'Valid for dine-in only. Cannot be combined with other offers. One claim per customer.',
                    style: context.bodyMedium.copyWith(
                      color: AppColors.subtitleTextColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Gap(32.h),

            // ── Bottom Action Buttons ──
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      AppStrings.pause.tr,
                      style: context.titleSmall.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Gap(16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => AppRouter.route.pushNamed(
                      RoutePath.editOfferScreen,
                      extra: deal,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      AppStrings.editOffer.tr,
                      style: context.titleSmall.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }
}
