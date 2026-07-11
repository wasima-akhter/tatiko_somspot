import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/influencer_all/influencer_task_screen/modules/influencer_task_status_tag.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import 'influencer_deliverable_card.dart';

class PendingPostLinkCard extends StatelessWidget {
  const PendingPostLinkCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Merchant + status
          Row(
            children: [
              Expanded(
                child: Text(
                  "Hoyat Supermarket",
                  style: context.bodySmall.copyWith(
                    color: AppColors.grayTextSecondaryColor,
                  ),
                ),
              ),

              InfluencerTaskStatusTag(status: TaskStatus.pendingFinalApproval),
            ],
          ),

          const SizedBox(height: 6),

          // Title
          Text(
            "Fresh Produce Spotlight",
            style: context.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 10),

          // Deliverable box
          InfluencerDeliverableCard(deliverable: "2 Instagram Stories"),

          const SizedBox(height: 10),

          // Link row
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              AppRouter.route.pushNamed(
                RoutePath.influencerYourSubmissionScreen,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.softBackgroundColor,
                borderRadius: BorderRadius.circular(8.r),
                // border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "https://instagram.com/p/CxYz123",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),

                  Text(
                    "Live post",
                    style: context.titleSmall.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(width: 6),

                  Icon(
                    Iconsax.export_3,
                    size: 14,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Waiting status
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.blueAccentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.clock, size: 14, color: AppColors.primaryColor),

                const SizedBox(width: 6),

                Text(
                  "Waiting for final post approval",
                  style: context.bodySmall.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 11,
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
