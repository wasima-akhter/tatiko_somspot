import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import 'deliverable_tile.dart';

class DeliverablesSection extends StatelessWidget {
  const DeliverablesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Deliverables",
          style: context.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.darkTextColor,
          ),
        ),

        SizedBox(height: 12),

        DeliverableTile(
          icon: Iconsax.video,
          color: AppColors.blackMainTextColor,
          title: "TikTok @ahmed_creates",
          followers: "50K Followers",
        ),

        DeliverableTile(
          icon: Iconsax.instagram,
          color: Colors.pink,
          title: "Instagram @ahmed_creates",
          followers: "22K Followers",
        ),
      ],
    );
  }
}
