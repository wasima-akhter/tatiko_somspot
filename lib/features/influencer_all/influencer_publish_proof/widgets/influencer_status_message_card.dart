import 'package:flutter/material.dart';

class StatusMessageCard extends StatelessWidget {
  final String title;
  final String message;
  final Color backgroundColor;
  final Color borderColor;
  final IconData? icon;

  const StatusMessageCard({
    super.key,
    required this.title,
    required this.message,
    required this.backgroundColor,
    required this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18),
                  const SizedBox(width: 6),
                ],
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          if (title.isNotEmpty) const SizedBox(height: 8),
          Text(message),
        ],
      ),
    );
  }
}
