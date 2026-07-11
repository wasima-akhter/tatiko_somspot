import 'package:flutter/material.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../utils/extension/base_extension.dart' show ContextExtensions;

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  final IconData? icon;

  final bool isOutlined;
  final Color? backgroundColor;

  const CustomButton({
    required this.text,
    this.onTap,
    this.isLoading = false,
    this.icon,
    this.isOutlined = false,
    super.key,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // final backgroundColor = isOutlined
    //     ? Colors.transparent
    //     : (isDark ? AppColors.white : AppColors.primaryColor);
    final borderColor = isOutlined
        ? AppColors.primaryColor.withValues(alpha: 0.5)
        : Colors.transparent;

    final bgColor = isOutlined
        ? Colors.transparent
        : (backgroundColor ??
              (isDark ? AppColors.white : AppColors.primaryColor));
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 48,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: isOutlined
                ? Border.all(color: borderColor, width: 1.5)
                : null,
            borderRadius: BorderRadius.circular(16),
          ),
          child: buildChild(context),
        ),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    if (isLoading) {
      return LoadingWidget(
        color: isOutlined ? AppColors.primaryColor : AppColors.white,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: isOutlined ? AppColors.primaryColor : AppColors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: context.titleMedium.copyWith(
              color: isOutlined ? AppColors.primaryColor : AppColors.white,
            ),
          ),
        ],
      );
    }
  }
}
