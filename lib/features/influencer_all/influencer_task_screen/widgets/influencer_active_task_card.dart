import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../core/influencer_tasks/response/influencer_tasks_response.dart';
import '../../influencer_submit_content/args/submit_content_args.dart';
import '../modules/influencer_task_status_tag.dart';
import 'task_info_box.dart';

class InfluencerTaskActiveCard extends StatelessWidget {
  final InfluencerTaskModel task;

  const InfluencerTaskActiveCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Merchant + Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  (task.campaign?.business?.name ?? '').capitalizeWords(),
                  style: context.bodyMedium.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              InfluencerTaskStatusTag(status: TaskStatus.active),
            ],
          ),

          SizedBox(height: 6.h),

          /// Campaign title
          Text(
            task.campaign?.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),

          SizedBox(height: 6.h),

          /// Campaign about
          Text(
            task.campaign?.about ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),

          SizedBox(height: 14.h),

          /// Content & Deadline
          Row(
            children: [
              Expanded(
                child: InfoBox(
                  icon: Icons.ondemand_video_outlined,
                  title: AppStrings.content.tr,
                  value: "1 ${task.campaign?.contentType.capitalize}",
                ),
              ),

              SizedBox(width: 10.w),

              Expanded(
                child: InfoBox(
                  icon: Icons.calendar_today_outlined,
                  title: AppStrings.deadline.tr,
                  value: DateConverter.formatDate(
                    dateTime: task.campaign?.endDate,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: CustomButton(
              text: AppStrings.submitContent.tr,
              icon: Icons.cloud_upload_outlined,
              backgroundColor: AppColors.primaryColor,
              onTap: () {
                AppRouter.route.pushNamed(
                  RoutePath.influencerSubmitContentScreen,
                  extra: SubmitContentArgs(
                    taskName: task.campaign?.about ?? '',
                    applicationId: task.id,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
