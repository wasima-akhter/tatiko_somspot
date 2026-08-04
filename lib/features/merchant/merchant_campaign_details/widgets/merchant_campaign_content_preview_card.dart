import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import 'merchat_campaign_video_badge.dart';

class MerchantCampaignContentPreviewCard extends StatelessWidget {
  const MerchantCampaignContentPreviewCard({
    super.key,
    required this.storeName,
    required this.title,
    required this.description,
    required this.platform,
    this.videoUrl,
    this.onPlay,
    this.thumbnail,
    this.duration,
    this.status,
    this.category,
    this.submittedDate,
    this.views,
    required this.storeImage,
  });

  final String storeName;
  final String storeImage;
  final String title;
  final String description;
  final String platform;

  final String? videoUrl;
  final String? thumbnail;
  final String? duration;
  final String? status;
  final String? category;
  final String? submittedDate;
  final String? views;

  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
          // Video Preview
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(18.r),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18.r),
                      ),
                      color: Colors.black,
                    ),

                    child: thumbnail != null && thumbnail!.isNotEmpty
                        ? CustomNetworkImage(
                            imageUrl: thumbnail!,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.video_library_outlined,
                                  color: Colors.white70,
                                  size: 44.sp,
                                ),
                                Gap(8.h),
                                Text(
                                  "Video Content",
                                  style: context.bodySmall.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),

                // Dark overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .25),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18.r),
                      ),
                    ),
                  ),
                ),

                // Platform
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: MerchantCampaignVideoBadge(platform: platform),
                ),

                // Duration
                if (duration != null)
                  Positioned(
                    right: 12.w,
                    top: 12.h,
                    child: _InfoBadge(
                      icon: Icons.timer_outlined,
                      text: duration!,
                    ),
                  ),

                // Play button
                Center(
                  child: GestureDetector(
                    onTap: onPlay,
                    child: Container(
                      height: 64.w,
                      width: 64.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: .95),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 38.sp,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Store
                Row(
                  children: [
                    // Icon(
                    //   Icons.storefront_outlined,
                    //   size: 18.sp,
                    //   color: AppColors.subtitleTextColor,
                    // ),

                    // Gap(6.w),
                    CircleAvatar(
                      radius: 12.r,
                      child: CustomNetworkImage(
                        imageUrl: storeImage,
                        boxShape: BoxShape.circle,
                      ),
                    ),
                    Gap(6.w),

                    Expanded(
                      child: Text(
                        storeName.capitalizeWords(),
                        style: context.bodyMedium.copyWith(
                          color: AppColors.subtitleTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    if (status != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: .12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          status!,
                          style: context.bodySmall.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),

                Gap(12.h),

                // Title
                Text(
                  title.capitalizeWords(),
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Gap(10.h),

                // Category
                if (category != null)
                  Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 16.sp,
                        color: AppColors.subtitleTextColor,
                      ),

                      Gap(6.w),

                      Text(
                        category!.capitalizeWords(),
                        style: context.bodySmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.subtitleTextColor,
                        ),
                      ),
                    ],
                  ),

                Gap(12.h),

                // Description
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Content Caption",
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Gap(6.h),

                      Text(
                        description,
                        style: context.bodyMedium.copyWith(
                          color: AppColors.subtitleTextColor,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(14.h),

                // Extra details
                Wrap(
                  spacing: 12.w,
                  runSpacing: 8.h,
                  children: [
                    if (submittedDate != null)
                      _DetailChip(
                        icon: Icons.calendar_today_outlined,
                        text: submittedDate!,
                      ),

                    if (views != null)
                      _DetailChip(
                        icon: Icons.visibility_outlined,
                        text: "$views views",
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .6),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: Colors.white),

          Gap(4.w),

          Text(
            text,
            style: context.bodySmall.copyWith(
              color: Colors.white,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: const Color(0xffF5F7FA),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15.sp, color: AppColors.subtitleTextColor),

          Gap(5.w),

          Text(
            text,
            style: context.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.subtitleTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
