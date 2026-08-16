// -----------------------------------------------------------------------------
// 2. Claims Header Widget (`claims_header_widget.dart`)
// -----------------------------------------------------------------------------
import 'package:som_spot/features/customer/claims/controller/claims_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../shared/helper/claims_helper.dart';

class ClaimsHeaderWidget extends GetView<ClaimsController> {
  const ClaimsHeaderWidget({super.key});

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
            AppStrings.myClaims.tr,
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
              final isActive = selectedTab == ClaimsTabType.active;

              return LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final itemWidth = totalWidth / 2;

                  return Stack(
                    children: [
                      // Smooth Sliding Pill Indicator Background
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        left: isActive ? 0 : itemWidth,
                        top: 0,
                        bottom: 0,
                        width: itemWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 6.r,
                                offset: Offset(0, 2.h),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Clickable Options Layer
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () =>
                                  controller.selectTab(ClaimsTabType.active),
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: context.bodyMedium.copyWith(
                                    color: isActive
                                        ? Colors.white
                                        : AppColors.subtitleTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                  child: Text(AppStrings.active.tr),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () =>
                                  controller.selectTab(ClaimsTabType.expired),
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: context.bodyMedium.copyWith(
                                    color: !isActive
                                        ? Colors.white
                                        : AppColors.subtitleTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                  child: Text(AppStrings.expired.tr),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
