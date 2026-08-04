import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'platform_tile.dart';

enum PlatformType { tiktok, instagram, facebook, youtube, twitter }

class PlatformSelector extends StatelessWidget {
  final PlatformType selected;
  final ValueChanged<PlatformType> onChanged;

  const PlatformSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PlatformTile(
                title: "TikTok",
                icon: Icons.music_video_outlined,
                isSelected: selected == PlatformType.tiktok,
                onTap: () => onChanged(PlatformType.tiktok),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: PlatformTile(
                title: "Instagram",
                icon: Icons.camera_alt_outlined,
                isSelected: selected == PlatformType.instagram,
                onTap: () => onChanged(PlatformType.instagram),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: PlatformTile(
                title: "Facebook",
                icon: Icons.facebook_outlined,
                isSelected: selected == PlatformType.facebook,
                onTap: () => onChanged(PlatformType.facebook),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: PlatformTile(
                title: "YouTube",
                icon: Icons.ondemand_video_outlined,
                isSelected: selected == PlatformType.youtube,
                onTap: () => onChanged(PlatformType.youtube),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: PlatformTile(
                title: "X (Twitter)",
                icon: Icons.alternate_email,
                isSelected: selected == PlatformType.twitter,
                onTap: () => onChanged(PlatformType.twitter),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}
