import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'platform_tile.dart';

enum PlatformType { tiktok, instagram, facebook }

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
    return Row(
      children: [
        Expanded(
          child: PlatformTile(
            title: "TikTok",
            icon: Icons.video_collection_outlined,
            isSelected: selected == PlatformType.tiktok,
            onTap: () => onChanged(PlatformType.tiktok),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: PlatformTile(
            title: "Instagram",
            icon: Icons.camera_alt_outlined,
            isSelected: selected == PlatformType.instagram,
            onTap: () => onChanged(PlatformType.instagram),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: PlatformTile(
            title: "Facebook",
            icon: Icons.facebook_outlined,
            isSelected: selected == PlatformType.facebook,
            onTap: () => onChanged(PlatformType.facebook),
          ),
        ),
      ],
    );
  }
}
