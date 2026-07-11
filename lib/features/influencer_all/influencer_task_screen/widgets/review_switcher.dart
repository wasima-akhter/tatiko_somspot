import 'package:flutter/material.dart';

import '../../../../utils/color/app_colors.dart';

class ReviewSwitcher extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const ReviewSwitcher({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _button(
              title: "Content",
              active: selected == 0,
              onTap: () => onChanged(0),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _button(
              title: "Post Link",
              active: selected == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: active
              ? AppColors.primaryColor
              : AppColors.softBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
