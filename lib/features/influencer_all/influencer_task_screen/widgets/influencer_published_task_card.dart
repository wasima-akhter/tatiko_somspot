import 'package:som_spot/share/controller/screen_export.dart';

import '../../core/influencer_tasks/response/influencer_tasks_response.dart';
import 'task_info_box.dart';

class InfluencerTaskPublishedCard extends StatelessWidget {
  final InfluencerTaskModel task;
  final VoidCallback? onViewPost;

  const InfluencerTaskPublishedCard({
    super.key,
    required this.task,
    this.onViewPost,
  });

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
          /// Header
          Row(
            children: [
              Expanded(
                child: Text(
                  task.campaign?.business?.name ?? '',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xffEEF6FF),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Published",
                  style: TextStyle(
                    color: const Color(0xff3B82F6),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),

          /// Campaign Title
          Text(
            task.campaign?.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xff1F2937),
            ),
          ),

          SizedBox(height: 14.h),

          /// Content Box
          InfoBox(
            icon: Icons.ondemand_video_outlined,
            title: "Content",
            value: "1 ${_capitalize(task.campaign?.contentType ?? '')} Video",
          ),

          SizedBox(height: 18.h),

          /// View Original Post Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onViewPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.blue.shade400,
                disabledForegroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: Text(
                "View Original Post",
                style: context.titleMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
