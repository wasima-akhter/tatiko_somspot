import 'package:som_spot/share/controller/screen_export.dart';

class CampaignCreateButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CampaignCreateButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        height: 42.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: .15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.add, size: 16.sp, color: Colors.white),

            SizedBox(width: 6.w),

            Text(
              "Create Campaign",
              style: context.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
