import '../../../../../share/export/screen_export.dart';
import '../../controller/search_controller.dart';

class NoSearchResultWidget extends StatelessWidget {
  const NoSearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SearchScreenController.to;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 62.w,
              height: 62.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.search_status,
                color: AppColors.primaryColor,
                size: 28.sp,
              ),
            ),

            Gap(14.h),

            Text(
              AppStrings.noItemsFound.tr,
              textAlign: TextAlign.center,
              style: context.titleMedium.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),

            Gap(6.h),

            Text(
              AppStrings.noSearchResults.tr,
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(
                color: AppColors.subtitleTextColor,
                height: 1.4,
              ),
            ),

            Gap(16.h),

            SizedBox(
              height: 40.h,
              child: OutlinedButton.icon(
                onPressed: controller.resetSearch,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: BorderSide(color: AppColors.primaryColor, width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                icon: Icon(Iconsax.refresh, size: 16.sp),
                label: Text(
                  AppStrings.resetSearch.tr,
                  style: context.bodySmall.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
