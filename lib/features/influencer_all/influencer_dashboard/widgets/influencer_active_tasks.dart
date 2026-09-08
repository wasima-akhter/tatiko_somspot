import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../response/influencer_dashboard_response.dart';

class InfluencerActiveTasks extends StatelessWidget {
  final InfluencerDashboardModel? data;
  final bool isLoading;

  const InfluencerActiveTasks({super.key, this.data, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Column(
        children: List.generate(
          3,
          (_) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: AutoShimmerAnimate(
              isLoading: true,
              baseColor: AppColors.shimmerBaseColor,
              highlightColor: Colors.white,
              child: _taskCard(
                context,
                restaurant: AppStrings.loadingBusiness.tr,
                title: AppStrings.loadingCampaignName.tr,
                subtitle: AppStrings.videoContent.tr,
                status: AppStrings.active.tr.toUpperCase(),
                statusColor: Colors.grey,
              ),
            ),
          ),
        ),
      );
    }

    final tasks = data?.activeTasks ?? [];

    if (tasks.isEmpty) {
      return _getEmptyActiveTaskPlaceholder(context);
    }

    return Column(
      children: tasks.map((task) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _taskCard(
            context,
            restaurant: task.businessName ?? AppStrings.unknownBusiness.tr,
            title: task.campaignName ?? "Campaign",
            subtitle: _getSubtitle(task),
            status: task.statusLabel ?? task.stage ?? "",
            statusColor: _getStatusColor(task.stage),
          ),
        );
      }).toList(),
    );
  }

  String _getSubtitle(InfluencerActiveTaskModel task) {
    final parts = <String>[];

    if (task.platform != null) {
      parts.add(task.platform!.capitalizeFirst!);
    }

    if (task.contentType != null) {
      parts.add(task.contentType!.replaceAll("_", " ").capitalizeFirst!);
    }

    return parts.isEmpty ? AppStrings.contentTask.tr : parts.join(" • ");
  }

  Color _getStatusColor(String? stage) {
    switch (stage?.toLowerCase()) {
      case "active":
        return AppColors.blueAccentColor;

      case "pending":
        return Colors.orange;

      case "completed":
        return AppColors.emeraldGreenColor;

      default:
        return AppColors.subtitleTextColor;
    }
  }

  Widget _taskCard(
    BuildContext context, {
    required String restaurant,
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  restaurant.capitalizeWords(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodySmall.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: context.bodySmall.copyWith(
                    color: statusColor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Gap(4.h),

          Text(
            title.capitalizeWords(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.titleMedium.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),

          Gap(4.h),

          Row(
            children: [
              Icon(Iconsax.video, size: 12.w),
              Gap(5.w),
              Text(
                subtitle.capitalizeWords(),
                style: context.bodySmall.copyWith(
                  color: AppColors.subtitleTextColor,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getEmptyActiveTaskPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blueAccentColor.withValues(alpha: .1),
            ),
            child: Icon(
              Iconsax.task_square,
              size: 22.sp,
              color: AppColors.blueAccentColor,
            ),
          ),

          Gap(12.h),

          Text(
            AppStrings.noActiveTasks.tr.capitalizeWords(),
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.darkTextColor,
            ),
          ),

          Gap(4.h),

          Text(
            AppStrings.assignedTasksSubtitle.tr,
            textAlign: TextAlign.center,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
