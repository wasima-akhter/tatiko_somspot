import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';

enum MerchantCampaignTab { all, pending, approved }

enum MerchantCampaignStatus { pending, approved }

class MerchantCampaignStatusTag extends StatelessWidget {
  final MerchantCampaignStatus status;

  const MerchantCampaignStatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        _text,
        style: TextStyle(
          color: _textColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String get _text {
    switch (status) {
      case MerchantCampaignStatus.pending:
        return "PENDING";

      case MerchantCampaignStatus.approved:
        return "APPROVED";
    }
  }

  Color get _backgroundColor {
    switch (status) {
      case MerchantCampaignStatus.pending:
        return Color(0xFFFFF7ED);

      case MerchantCampaignStatus.approved:
        return AppColors.primaryColor.withValues(alpha: .12);
    }
  }

  Color get _textColor {
    switch (status) {
      case MerchantCampaignStatus.pending:
        return Colors.orange;

      case MerchantCampaignStatus.approved:
        return AppColors.primaryColor;
    }
  }
}
