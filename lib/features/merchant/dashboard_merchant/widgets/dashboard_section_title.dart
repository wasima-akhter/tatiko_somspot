import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const DashboardSectionTitle({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: trailing != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),

        ?trailing,
      ],
    );
  }
}
