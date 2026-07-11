import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import '../modules/influencer_task_status_tag.dart';
import 'influencer_deliverable_card.dart';
import 'influencer_merchant_name.dart';

class CompletedTaskCard extends StatelessWidget {
  final Map<String, dynamic> task;

  const CompletedTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Merchant + Status
          Row(
            children: [
              Expanded(
                child: InfluencerMerchantName(merchant: task["merchant"]),
              ),
              InfluencerTaskStatusTag(status: TaskStatus.completed),
            ],
          ),

          Gap(6.h),

          Text(
            task["title"],
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),

          Gap(14.h),

          InfluencerDeliverableCard(deliverable: task["deliverable"]),

          Gap(14.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xffEAFBF1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xff22C55E)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Color(0xff22C55E),
                  size: 18.sp,
                ),

                Gap(8.w),

                Expanded(
                  child: Text(
                    "Earned \$${task["earned"]}",
                    style: context.bodyMedium.copyWith(
                      color: const Color(0xff22C55E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View Content",
                    style: context.titleSmall.copyWith(
                      color: AppColors.purpleAccentColor,
                      fontWeight: FontWeight.w600,
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
