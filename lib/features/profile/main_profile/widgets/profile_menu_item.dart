import 'package:som_spot/share/export/screen_export.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.grayTextSecondaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: AppColors.grayTextSecondaryColor,
                size: 16.sp,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Text(
                title,
                style: context.bodyLarge.copyWith(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Icon(
              Iconsax.arrow_right_3,
              color: AppColors.hintTextColor,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
