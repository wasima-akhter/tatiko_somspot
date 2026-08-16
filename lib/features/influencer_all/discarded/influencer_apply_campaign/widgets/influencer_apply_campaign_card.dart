import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../../../utils/color/app_colors.dart';
import '../../../../../../utils/extension/base_extension.dart';

class CampaignCard extends StatelessWidget {
  const CampaignCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomNetworkImage(
              imageUrl:
                  "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mogadishu Pizza",
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
                const Gap(4),
                Text(
                  "Buy 1 Get 1 Free Promo",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
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
