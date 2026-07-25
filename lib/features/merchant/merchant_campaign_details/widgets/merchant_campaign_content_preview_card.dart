import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import 'merchat_campaign_video_badge.dart';

class MerchantCampaignContentPreviewCard extends StatelessWidget {
  const MerchantCampaignContentPreviewCard({
    super.key,
    required this.image,
    required this.storeName,
    required this.title,
    required this.description,
    required this.platform,
    this.onPlay,
  });

  final String image;
  final String storeName;
  final String title;
  final String description;
  final String platform;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CustomNetworkImage(
                imageUrl: image,
                height: 390.h,
                width: double.infinity,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.r),
                  topRight: Radius.circular(18.r),
                ),
              ),

              Positioned(
                top: 12.h,
                left: 12.w,
                child: MerchantCampaignVideoBadge(platform: platform),
              ),

              GestureDetector(
                onTap: onPlay,
                child: Container(
                  width: 68.w,
                  height: 68.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  child: Center(
                    child: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.deepPurple, width: 2),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.deepPurple,
                        size: 26.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),

                Gap(4.h),

                Text(
                  title,
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Gap(8.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    description,
                    style: context.bodyMedium.copyWith(
                      color: AppColors.subtitleTextColor,
                      height: 1.4,
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
