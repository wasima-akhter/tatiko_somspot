import 'package:flutter/material.dart';
import 'package:som_spot/features/influencer_all/influencer_task_screen/modules/influencer_task_status_tag.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class PendingContentCard extends StatelessWidget {
  const PendingContentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Mogadishu Pizza",
                  style: context.bodySmall.copyWith(
                    color: AppColors.grayTextSecondaryColor,
                  ),
                ),
              ),

              InfluencerTaskStatusTag(
                status: TaskStatus.pendingReview,
                radius: 6,
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "Buy 1 Get 1 Free Promo",
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Text(
            "Deliverable",
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.softBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.videocam_outlined,
                  color: Colors.deepPurple,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Text("2 Instagram Stories"),
              ],
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("View Submission"),
            ),
          ),
        ],
      ),
    );
  }
}
