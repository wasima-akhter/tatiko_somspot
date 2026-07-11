import 'package:flutter/material.dart';

import '../../../../utils/extension/base_extension.dart';

class CaptionSection extends StatelessWidget {
  const CaptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          "Caption",
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 8),

        Container(
          width: double.infinity,

          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),

          child: Text(
            "Best Pizza in Mogadishu! 🍕 Buy 1 Get 1 Free today through @SomSpot — link in bio! #MogadishuEats #SomSpot",
            style: context.bodySmall,
          ),
        ),
      ],
    );
  }
}
