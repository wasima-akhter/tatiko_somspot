import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../core/influencer_tasks/response/influencer_tasks_response.dart';
import 'task_info_box.dart';

class InfluencerTaskCompletedCard extends StatelessWidget {
  final InfluencerTaskModel task;

  const InfluencerTaskCompletedCard({super.key, required this.task});

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
          Row(
            children: [
              Expanded(
                child: Text(
                  (task.campaign?.business?.name ?? '').capitalizeWords(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xffEAFBF1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Merchant approved",
                  style: TextStyle(
                    color: const Color(0xff22C55E),
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
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.sp),
          ),

          SizedBox(height: 14.h),

          InfoBox(
            icon: Icons.ondemand_video_outlined,
            title: "Content",
            value: "1 ${task.campaign?.contentType.capitalizeWords()} Video",
          ),

          SizedBox(height: 12.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xffECFDF3),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xff22C55E),
                  size: 18,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Ready to publish to social media.",
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
            child: ElevatedButton.icon(
              onPressed: () {
                AppRouter.route.pushNamed(
                  RoutePath.influencerPublishProofScreen,
                );
              },
              icon: const Icon(Icons.send_outlined),
              label: const Text("Publish to Social Media"),
            ),
          ),
        ],
      ),
    );
  }
}
