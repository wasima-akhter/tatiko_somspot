import 'package:url_launcher/url_launcher.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../model/home_content_creator_model.dart';
import 'content_badge.dart';

class RecommendedContentCard extends StatelessWidget {
  const RecommendedContentCard({super.key, required this.content});

  final CreatorContentModel content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openPost,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImage(context), _buildContent(context)],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return SizedBox(
      height: 155.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomNetworkImage(imageUrl: content.thumbnail, fit: BoxFit.cover),

          Container(color: Colors.black.withValues(alpha: 0.08)),

          Positioned(
            top: 10.h,
            left: 10.w,
            child: ContentBadge(icon: _platformIcon, text: _platformName),
          ),

          Positioned(bottom: 10.h, left: 10.w, child: _buildCreator(context)),

          Positioned(
            bottom: 10.h,
            right: 10.w,
            child: Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreator(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          padding: EdgeInsets.all(1.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: CustomNetworkImage(
            imageUrl: content.creator.profileImage,
            boxShape: BoxShape.circle,
            fit: BoxFit.cover,
          ),
        ),

        Gap(5.w),

        Text(
          '@${content.creator.name}',
          style: context.bodySmall.copyWith(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
              fontSize: 12.sp,
            ),
          ),

          Gap(6.h),

          Text(
            content.campaign.business.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.bodySmall.copyWith(
              color: AppColors.primaryColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String get _platformName {
    switch (content.platform.toLowerCase()) {
      case 'tiktok':
        return 'TikTok';

      case 'instagram':
        return 'Instagram';

      case 'youtube':
        return 'YouTube';

      default:
        return content.platform;
    }
  }

  IconData get _platformIcon {
    switch (content.platform.toLowerCase()) {
      case 'tiktok':
        return Icons.music_note_rounded;

      case 'instagram':
        return Icons.camera_alt_outlined;

      case 'youtube':
        return Icons.smart_display_outlined;

      default:
        return Icons.play_circle_outline_rounded;
    }
  }

  Future<void> _openPost() async {
    if (content.postUrl.isEmpty) {
      return;
    }

    final uri = Uri.tryParse(content.postUrl);

    if (uri == null) {
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
