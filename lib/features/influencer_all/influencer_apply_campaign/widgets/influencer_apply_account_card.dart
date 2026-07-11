import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../utils/color/app_colors.dart';
import '../../../../../utils/extension/base_extension.dart';

class AccountTile extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String followers;

  const AccountTile({
    super.key,
    required this.selected,
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.primaryColor
                : Colors.white.withValues(alpha: 0.15),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const Gap(12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackMainTextColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    followers,
                    style: context.bodySmall.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                ],
              ),
            ),

            Radio<int>(
              value: selected ? 1 : 0,
              groupValue: 1,
              activeColor: AppColors.primaryColor,
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}
