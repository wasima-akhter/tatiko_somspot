import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:som_spot/core/router/routes.dart';

import '../../../../core/router/route_path.dart';
import '../../../../share/widgets/button/custom_button.dart';
import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import '../modules/influencer_task_status_tag.dart';
import 'influencer_deliverable_card.dart';
import 'influencer_merchant_name.dart';

class InfluencerTaskCard extends StatelessWidget {
  final Map<String, dynamic> task;

  const InfluencerTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final bool approved = task["approved"];

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.all(12.w),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InfluencerMerchantName(merchant: task["merchant"]),
                ),

                InfluencerTaskStatusTag(
                  status: approved ? TaskStatus.approved : TaskStatus.active,
                ),
              ],
            ),

            SizedBox(height: 6.h),

            Text(
              task["title"],
              style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8.h),

            InfluencerDeliverableCard(deliverable: task["deliverable"]),

            if (approved) ...[
              SizedBox(height: 12.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Merchant note",
                      style: context.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Text(task["note"]),
                  ],
                ),
              ),
            ],

            SizedBox(height: 14.h),

            SizedBox(
              height: 42.h,
              child: CustomButton(
                text: approved ? "Download Content" : "Submit Content",
                icon: approved ? Icons.file_download_outlined : null,
                backgroundColor: approved
                    ? Colors.green
                    : AppColors.primaryColor,
                onTap: () {
                  if (!approved) {
                    AppRouter.route.pushNamed(
                      RoutePath.influencerSubmitContentScreen,
                    );
                  } else {
                    AppRouter.route.pushNamed(
                      RoutePath.influencerPublishProofScreen,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
