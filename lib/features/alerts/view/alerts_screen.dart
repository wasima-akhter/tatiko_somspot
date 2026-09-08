import 'package:intl/intl.dart';
import 'package:som_spot/features/alerts/controller/alerts_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../share/widgets/ui_status_builder/sliver_api_status_builder.dart';
import '../widgets/alerts_screen_skeleton.dart';

class AlertsScreen extends GetView<AlertsScreenController> {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      onPressed: () => AppRouter.route.pop(),
      title: AppStrings.notifications.tr,

      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: controller.markAllAsRead,
              child: Obx(() {
                return controller.markAllStatus.value == ApiStatus.loading
                    ? LoadingWidget()
                    : Text(
                        AppStrings.markAllRead.tr,
                        style: context.titleSmall.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      );
              }),
            ),
          ),
        ),
      ],
      body: Container(
        width: double.infinity,
        color: AppColors.primaryColor.withValues(alpha: 0.05),
        child: RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                sliver: Obx(
                  () => ApiSliverStatusBuilder(
                    status: controller.paginator.status.value,
                    errorMessage: controller.paginator.errorMessage.value,
                    onRetry: controller.refreshNotifications,
                    loadingWidget: const AlertsScreenSkeleton(),
                    isLoadingMore:
                        controller.paginator.loadMoreStatus.value ==
                        ApiStatus.loading,
                    hasMore: controller.paginator.hasMore.value,
                    builder: (_) {
                      final notifications = controller.notifications;

                      return SliverList.separated(
                        itemCount: notifications.length,
                        separatorBuilder: (_, _) => Gap(12.h),
                        itemBuilder: (context, index) {
                          final notification = notifications[index];

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              controller.toggleUnread(index);
                            },
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            height: 1.4,
                                          ),
                                        ),
                                        Gap(6.h),
                                        Text(
                                          formatNotificationTime(
                                            dateTime: notification.time,
                                          ),
                                          style: context.bodyMedium.copyWith(
                                            color: AppColors.hintTextColor,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(() {
                                    if (!notification.isUnread.value) {
                                      return const SizedBox.shrink();
                                    }

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
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatNotificationTime({required String? dateTime}) {
  if (dateTime == null || dateTime.trim().isEmpty) {
    return '';
  }

  try {
    final date = DateTime.parse(dateTime).toLocal();
    final now = DateTime.now();

    final difference = now.difference(date);

    // Future timestamps due to clock differences
    if (difference.isNegative) {
      return 'Just now';
    }

    if (difference.inSeconds < 60) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'min' : 'mins'} ago';
    }

    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }

    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    }

    // Older notifications
    return DateFormat('MMM d, yyy').format(date);
  } catch (e) {
    return '';
  }
}
