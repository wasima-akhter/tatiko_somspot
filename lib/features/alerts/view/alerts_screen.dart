import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/features/alerts/controller/alerts_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';

class AlertsScreen extends GetView<AlertsScreenController> {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.softBackgroundColor,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.notifications.tr,
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: GestureDetector(
                onTap: () => controller.markAllAsRead(),
                child: Text(
                  AppStrings.markAllRead.tr,
                  style: context.titleSmall.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Scrollable Notifications Feed
          Expanded(
            child: Container(
              width: double.infinity,
              color: AppColors.primaryColor.withValues(alpha: 0.05),
              child: Obx(() {
                final isLoading = controller.rxIsLoading.value;

                return AutoShimmerAnimate(
                  isLoading: isLoading,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    itemCount: controller.rxNotifications.length,
                    separatorBuilder: (context, index) => Gap(12.h),
                    itemBuilder: (context, index) {
                      final notification = controller.rxNotifications[index];
                      return GestureDetector(
                        onTap: () => controller.toggleUnread(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 8.r,
                                offset: Offset(0, 2.h),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(16.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Notification Bell Icon Block
                              Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Iconsax.notification,
                                  color: AppColors.primaryColor,
                                  size: 20.sp,
                                ),
                              ),
                              Gap(12.w),
                              // Message Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification.title,
                                      style: context.titleMedium.copyWith(
                                        color: AppColors.darkTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Gap(4.h),
                                    Text(
                                      notification.description,
                                      style: context.bodyMedium.copyWith(
                                        color: AppColors.subtitleTextColor,
                                        fontSize: 12.sp,
                                        height: 1.4.h,
                                      ),
                                    ),
                                    Gap(6.h),
                                    Text(
                                      notification.time,
                                      style: context.bodyMedium.copyWith(
                                        color: AppColors.hintTextColor,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Unread Blue Dot
                              Obx(() {
                                if (notification.isUnread.value) {
                                  return Container(
                                    width: 8.w,
                                    height: 8.h,
                                    margin: EdgeInsets.only(
                                      top: 4.h,
                                      left: 8.w,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
