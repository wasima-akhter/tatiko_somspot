import 'package:flutter/material.dart';

import '../../../../utils/color/app_colors.dart';

class ProgressLine extends StatelessWidget {
  final bool active;
  final bool isLeft;

  const ProgressLine({super.key, required this.active, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,

      decoration: BoxDecoration(
        color: active ? AppColors.emeraldGreenColor : AppColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
