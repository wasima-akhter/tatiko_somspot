import '../../../../../../share/export/screen_export.dart';

class MerchantAboutInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final Color? iconColor;

  const MerchantAboutInfoRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor ?? AppColors.primaryColor, size: 20.sp),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? AppColors.darkTextColor,
                ),
              ),
              if (subtitle != null) ...[
                Gap(2.h),
                Text(
                  subtitle!,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
