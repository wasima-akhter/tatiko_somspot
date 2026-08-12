import '../../../../../share/controller/screen_export.dart';

class NoRecentSearchWidget extends StatelessWidget {
  const NoRecentSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.backgroundsLinesColor,
            width: 1.w,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 52.h,
              width: 52.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.clock,
                size: 24.sp,
                color: AppColors.primaryColor,
              ),
            ),
            Gap(12.h),
            Text(
              "No Recent Searches",
              style: context.titleMedium.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(4.h),
            Text(
              "Your recent searches will appear here",
              style: context.bodyMedium.copyWith(
                color: AppColors.hintTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
