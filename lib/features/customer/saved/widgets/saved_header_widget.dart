// -----------------------------------------------------------------------------
// 2. Saved Header Widget
// -----------------------------------------------------------------------------
import 'package:som_spot/features/customer/saved/controller/saved_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../helper/saved_helper.dart';
import 'saved_tab_item_widget.dart';

class SavedHeaderWidget extends GetView<SavedScreenController> {
  const SavedHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.saved.tr,
            style: context.titleLarge.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
          Gap(16.h),
          Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(4.w),
            child: Obx(() {
              final selectedTab = controller.rxSelectedTab.value;

              return Row(
                children: [
                  SavedTabItemWidget(
                    title: AppStrings.businesses.tr,
                    selected: selectedTab == SavedTabType.businesses,
                    onTap: () => controller.selectTab(SavedTabType.businesses),
                  ),
                  SavedTabItemWidget(
                    title: AppStrings.offers.tr,
                    selected: selectedTab == SavedTabType.offers,
                    onTap: () => controller.selectTab(SavedTabType.offers),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
