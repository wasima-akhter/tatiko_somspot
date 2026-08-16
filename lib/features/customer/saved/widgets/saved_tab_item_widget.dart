// -----------------------------------------------------------------------------
// 3. Saved Tab Item Widget
// -----------------------------------------------------------------------------
import 'package:som_spot/share/export/screen_export.dart';

class SavedTabItemWidget extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const SavedTabItemWidget({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4.r,
                      offset: Offset(0, 2.h),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: context.bodyMedium.copyWith(
              color: selected
                  ? AppColors.primaryColor
                  : AppColors.subtitleTextColor,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
