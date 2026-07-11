import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color/app_colors.dart';

enum TaskStatus {
  active,
  approved,
  pendingReview,
  completed,
  pendingFinalApproval,
}

class InfluencerTaskStatusTag extends StatelessWidget {
  final TaskStatus status;
  final double radius;

  const InfluencerTaskStatusTag({
    super.key,
    required this.status,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(radius.r),
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
      case TaskStatus.active:
        return "ACTIVE";
      case TaskStatus.approved:
        return "APPROVED";
      case TaskStatus.pendingReview:
        return "PENDING REVIEW";
      case TaskStatus.completed:
        return "COMPLETED";
      case TaskStatus.pendingFinalApproval:
        return "Pending Final Approval";
    }
  }

  Color get _backgroundColor {
    switch (status) {
      case TaskStatus.active:
        return AppColors.primaryColor.withOpacity(.12);
      case TaskStatus.approved:
        return Colors.green.withOpacity(.12);
      case TaskStatus.pendingReview:
        return Colors.orange.shade50;
      case TaskStatus.completed:
        return const Color(0xffEAFBF1);
      case TaskStatus.pendingFinalApproval:
        return AppColors.primaryColor.withOpacity(.12);
    }
  }

  Color get _textColor {
    switch (status) {
      case TaskStatus.active:
        return AppColors.primaryColor;
      case TaskStatus.approved:
        return Colors.green;
      case TaskStatus.pendingReview:
        return Colors.orange;
      case TaskStatus.completed:
        return const Color(0xff22C55E);
      case TaskStatus.pendingFinalApproval:
        return AppColors.primaryColor;
    }
  }
}
