import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';
import '../../merchant_new_campaign/shared/helper/campaign_helper.dart';

class MerchantCampaignStatusTag extends StatelessWidget {
  final MerchantCampaignStatus status;

  const MerchantCampaignStatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),

      child: Text(
        status.displayName,

        style: TextStyle(
          color: textColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Color get backgroundColor {
    switch (status) {
      case MerchantCampaignStatus.pendingReview:
        return const Color(0xFFFFF7ED);

      case MerchantCampaignStatus.live:
        return AppColors.primaryColor.withValues(alpha: .12);

      case MerchantCampaignStatus.draft:
        return Colors.grey.withValues(alpha: .12);
    }
  }

  Color get textColor {
    switch (status) {
      case MerchantCampaignStatus.pendingReview:
        return Colors.orange;

      case MerchantCampaignStatus.live:
        return AppColors.primaryColor;

      case MerchantCampaignStatus.draft:
        return Colors.grey;
    }
  }
}
