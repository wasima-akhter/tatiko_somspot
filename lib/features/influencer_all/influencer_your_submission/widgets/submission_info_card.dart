import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../share/controller/screen_export.dart';
import '../../core/influencer_tasks/response/influencer_tasks_response.dart';

class SubmissionInfoCard extends StatelessWidget {
  final InfluencerTaskModel task;

  const SubmissionInfoCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final campaign = task.campaign;

    final businessName = campaign?.business?.name ?? AppStrings.business.tr;
    final campaignTitle = campaign?.name ?? AppStrings.campaign.tr;

    final platform = (task.platform ?? "").toLowerCase();

    final platformLabel = switch (platform) {
      "youtube" => AppStrings.youtubeShort.tr,
      "instagram" => AppStrings.instagramReel.tr,
      "facebook" => AppStrings.facebookReel.tr,
      "tiktok" => AppStrings.tiktokVideo.tr,
      "twitter" || "x" => AppStrings.xPost.tr,
      _ => AppStrings.socialMediaPost.tr,
    };

    final platformIcon = switch (platform) {
      "youtube" => Icons.play_circle_outline,
      "instagram" => Icons.camera_alt_outlined,
      "facebook" => Icons.facebook,
      "tiktok" => Icons.music_note,
      "twitter" || "x" => Icons.alternate_email,
      _ => Icons.public,
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            businessName.capitalizeWords(),
            style: context.bodySmall.copyWith(
              color: AppColors.grayTextSecondaryColor,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            campaignTitle.capitalizeWords(),
            style: context.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 10),

          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.softBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  platformIcon,
                  size: 15.sp,
                  color: AppColors.purpleAccentColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${1} $platformLabel",
                    style: context.bodyMedium.copyWith(
                      color: AppColors.purpleAccentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
