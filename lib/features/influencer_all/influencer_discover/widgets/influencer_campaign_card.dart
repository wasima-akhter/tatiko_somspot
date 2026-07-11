import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../utils/extension/base_extension.dart';

class InfluencerCampaignCard extends StatelessWidget {
  final Map<String, dynamic> campaign;

  const InfluencerCampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),

            blurRadius: 10,

            offset: const Offset(0, 4),
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
                  imageUrl: campaign["image"],

                  height: 150.h,

                  width: double.infinity,

                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                right: 10.w,

                top: 10.h,

                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(12.r),
                  ),

                  child: Text(
                    campaign["reward"],

                    style: context.bodySmall.copyWith(
                      color: AppColors.purpleAccentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(12.w),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  campaign["merchant"],

                  style: context.bodySmall.copyWith(
                    color: AppColors.grayTextSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 5.h),

                Text(
                  campaign["title"],

                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                ),

                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    _InfoChip(icon: Iconsax.tag, text: campaign["campaign"]),

                    SizedBox(width: 8.w),

                    _InfoChip(icon: Iconsax.clock, text: campaign["days"]),
                  ],
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 38.h,
                  child: ElevatedButton(
                    onPressed: () {
                      AppRouter.route.pushNamed(
                        RoutePath.influencerCampaignDetailsScreen,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueAccentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "View Details",
                      style: context.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final Color? textColor;

  const _InfoChip({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),

      decoration: BoxDecoration(
        color: AppColors.grayTertiaryTextColor.withValues(alpha: 0.1),

        borderRadius: BorderRadius.circular(8.r),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(
            icon,
            size: 12.sp,
            color: iconColor ?? AppColors.blackMainTextColor,
          ),

          SizedBox(width: 3.w),

          Text(
            text,

            style: context.bodySmall.copyWith(
              fontSize: 10.sp,
              color: textColor ?? AppColors.blackMainTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class CampaignCardSkeleton extends StatelessWidget {
  const CampaignCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image placeholder (no Positioned/Stack needed for a flat skeleton)
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Container(
              height: 150.h,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bar(width: 80.w, height: 10.h),
                SizedBox(height: 8.h),
                _bar(width: 160.w, height: 14.h),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    _chip(width: 70.w),
                    SizedBox(width: 8.w),
                    _chip(width: 70.w),
                  ],
                ),
                SizedBox(height: 12.h),
                _bar(width: double.infinity, height: 38.h, radius: 10.r),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar({required double width, required double height, double? radius}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius ?? 4.r),
      ),
    );
  }

  Widget _chip({required double width}) {
    return Container(
      width: width,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
