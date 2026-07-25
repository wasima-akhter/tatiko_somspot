import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:som_spot/features/customer/home/model/merchant_model.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class MerchantHeaderBackdrop extends StatelessWidget {
  final MerchantModel merchant;

  const MerchantHeaderBackdrop({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          CustomNetworkImage(imageUrl: merchant.imageUrl, fit: BoxFit.cover),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Info overlay at the bottom of the image
          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Category Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        merchant.category,
                        style: context.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Gap(8.w),
                    // Rating Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(6.r),
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
                            "${merchant.rating} (124)",
                            style: context.bodySmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(8.h),
                Text(
                  merchant.title,
                  style: context.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
