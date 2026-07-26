import '../../../share/controller/screen_export.dart';
import '../controller/subscription_controller.dart';

class SubscriptionTabSelector extends StatelessWidget {
  const SubscriptionTabSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SubscriptionController.to;

    return Obx(() {
      final selectedIndex = controller.selectedTabIndex.value;

      return Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.backgroundsLinesColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? AppColors.blueAccentColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Subscriptions'.tr,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: selectedIndex == 0
                          ? AppColors.white
                          : AppColors.subtitleTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(1),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: selectedIndex == 1
                        ? AppColors.purpleAccentColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Influencer Boost'.tr,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: selectedIndex == 1
                          ? AppColors.white
                          : AppColors.subtitleTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
