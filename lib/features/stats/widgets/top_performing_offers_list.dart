import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../../../share/widgets/network_image/custom_network_image.dart';

class TopPerformingOffersList extends StatelessWidget {
  const TopPerformingOffersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.topPerformingOffers.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        Gap(16.h),
        _buildItem(
          context: context,
          imagePath:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=600&auto=format&fit=crop',
          title: '20% Off Family Platter',
          claims: 64,
          percentage: '+18%',
        ),
        _buildItem(
          context: context,
          imagePath:
              'https://images.unsplash.com/photo-1511920170033-f8396924c348?q=80&w=600&auto=format&fit=crop',
          title: 'Buy 1 Get 1 Free - Fresh...',
          claims: 64,
          percentage: '+12%',
        ),
        _buildItem(
          context: context,
          imagePath:
              'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop',
          title: '\$5 Iced Latte & Pastry',
          claims: 64,
          percentage: '+09%',
        ),
      ],
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required String imagePath,
    required String title,
    required int claims,
    required String percentage,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CustomNetworkImage(
              imageUrl: imagePath,
              width: 48.w,
              height: 48.w,
              fit: BoxFit.cover,
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(4.h),
                Text(
                  'Claims $claims',
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ),
          ),
          Gap(12.w),
          Text(
            percentage,
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.emeraldGreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
