import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import 'campaign_stat_card.dart';

class CampaignInfoCards extends StatelessWidget {
  const CampaignInfoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),

      child: Column(
        children: [
          Row(
            children: [
              CampaignStatCard(
                icon: Icons.track_changes_sharp,
                title: "Objective",
                value: "Offer Campaign",
                color: AppColors.blueAccentColor,
                filledBackground: false,
              ),

              SizedBox(width: 10.w),

              CampaignStatCard(
                icon: Iconsax.dollar_circle,
                title: "Commission",
                value: "\$5 / Claim",
                color: AppColors.purpleAccentColor,
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Container(
            width: double.infinity,

            padding: EdgeInsets.all(12.w),

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(12.r),

              border: Border.all(color: Colors.grey.withValues(alpha: .15)),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "About the Campaign",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.darkTextColor,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  "Promote our new BOGO pizza offer. We are looking for foodies to come taste and share their experience with their audience!",
                  style: context.bodySmall.copyWith(
                    color: AppColors.grayTextSecondaryColor,
                    fontSize: 12.sp,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
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
