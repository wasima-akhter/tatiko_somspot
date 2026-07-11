import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../utils/extension/base_extension.dart';
import 'video_stat_badge.dart';

class SubmittedVideoSection extends StatelessWidget {
  const SubmittedVideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          "Submitted Video",
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),

        SizedBox(height: 8.h),

        ClipRRect(
          borderRadius: BorderRadius.circular(14.r),

          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CustomNetworkImage(
                imageUrl:
                    "https://images.unsplash.com/photo-1513104890138-7c749659a591",
                height: 1.sh * 0.32,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Center(
                child: CircleAvatar(
                  radius: 22.r,

                  backgroundColor: Colors.white.withValues(alpha: 0.9),

                  child: Icon(
                    Iconsax.play_circle,
                    size: 24.r,
                    color: Colors.deepPurple,
                  ),
                ),
              ),

              Positioned(
                bottom: 10,
                left: 10,
                child: VideoStatBadge(
                  icon: Icons.visibility_outlined,
                  value: "24.5K",
                ),
              ),

              Positioned(
                bottom: 10,
                right: 10,
                child: VideoStatBadge(
                  icon: Icons.favorite_border,
                  value: "3.1K",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
