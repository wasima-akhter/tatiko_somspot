import 'package:som_spot/features/influencer_all/influencer_your_submission/args/influencer_submission_args.dart';
import 'package:som_spot/features/influencer_all/influencer_your_submission/widgets/verification_banner.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../core/influencer_tasks/response/influencer_tasks_response.dart';
import 'task_info_box.dart';

class InfluencerTaskPendingCard extends StatelessWidget {
  final InfluencerTaskModel task;

  const InfluencerTaskPendingCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top
          Row(
            children: [
              Expanded(
                child: Text(
                  (task.campaign?.business?.name ?? '').capitalizeWords(),
                  style: context.bodyMedium.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xffFFF4E5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  AppStrings.pendingMerchantReview.tr,
                  style: TextStyle(
                    color: const Color(0xffF59E0B),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          Text(
            (task.campaign?.name ?? '').capitalizeWords(),
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19.sp),
          ),

          SizedBox(height: 14.h),

          Row(
            children: [
              Expanded(
                child: InfoBox(
                  icon: Icons.ondemand_video_outlined,
                  title: AppStrings.content.tr,
                  value:
                      "1 ${task.campaign?.contentType} ${AppStrings.video.tr}",
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
                  time: DateConverter.formatTime(
                    dateTime: task.campaign?.endDate,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xffFFF8F0),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xffF59E0B),
                  size: 18,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    AppStrings.sentToMerchantForReview.tr,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: ElevatedButton(
              onPressed: () {
                AppRouter.route.pushNamed(
                  RoutePath.influencerYourSubmissionScreen,
                  extra: InfluencerSubmissionArgs(
                    applicationId: task.id,
                    status: SubmissionStatus.pendingReview,
                  ),
                );
              },

              child: Text(AppStrings.viewSubmission.tr),
            ),
          ),
        ],
      ),
    );
  }
}
