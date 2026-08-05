import 'package:som_spot/features/merchant/merchant_campaign_details/controller/merchant_campaign_details_controller.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/snackbar/api_snackbar.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../share/widgets/video/video_overlay.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_model.dart';

class MerchantCampaignContentCard extends StatelessWidget {
  final CampaignContentModel data;

  const MerchantCampaignContentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.route.pushNamed(
        RoutePath.merchantCampaignContentDetailsScreen,
        extra: data.id,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail / Preview
            AspectRatio(
              aspectRatio: 1.6,

              child: Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: data.thumbnail ?? "",
                    fit: BoxFit.cover,

                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),

                  // Play button overlay
                  if (data.draftVideoUrl != null &&
                      data.draftVideoUrl!.isNotEmpty)
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          AppVideoOverlay.show(
                            context,

                            videoUrl: data.draftVideoUrl!,

                            title: "Submitted Content",
                          );
                        },

                        child: Container(
                          height: 52.h,
                          width: 52.w,

                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: .55),

                            shape: BoxShape.circle,
                          ),

                          child: Icon(
                            Icons.play_arrow_rounded,

                            color: Colors.white,

                            size: 34.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r,

                        child: CustomNetworkImage(
                          boxShape: BoxShape.circle,
                          imageUrl: data.creator.profileImage,
                        ),
                      ),

                      Gap(6.w),

                      Expanded(
                        child: Text(
                          data.creator.name.capitalizeWords(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        " • ${data.submittedAt != null ? DateConverter.formatTime(dateTime: data.submittedAt) : ''}",
                        style: context.titleSmall.copyWith(
                          fontSize: 11.sp,
                          color: AppColors.subtitleTextColor,
                        ),
                      ),
                    ],
                  ),

                  Gap(12.h),

                  // Caption
                  if ((data.caption ?? "").isNotEmpty)
                    Text(
                      data.caption!.capitalizeWords(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  Gap(8.h),

                  // Platform + media type
                  Row(
                    children: [
                      if ((data.platform ?? "").isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),

                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),

                          child: Text(
                            data.platform!.toUpperCase(),
                            style: context.bodySmall.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      Gap(8.w),

                      if (data.draftMediaType.isNotEmpty)
                        Text(
                          data.draftMediaType.toUpperCase(),
                          style: context.bodySmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.subtitleTextColor,
                          ),
                        ),
                    ],
                  ),

                  Gap(14.h),
                  if ((data.status == "draft_submitted" &&
                      data.draftApproved == false))
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => CustomButton(
                              isLoading:
                                  MerchantCampaignDetailsController
                                      .to
                                      .contentActionLoading
                                      .value ==
                                  "reject",

                              text: "Reject",

                              isOutlined: true,

                              outlineColor: Colors.red,

                              foregroundColor: Colors.red,

                              onTap: () async {
                                await _showRejectDialog(
                                  context,
                                  MerchantCampaignDetailsController
                                      .to
                                      .reasonController,
                                );
                              },
                            ),
                          ),
                        ),

                        Gap(12.w),

                        Expanded(
                          child: Obx(
                            () => CustomButton(
                              isLoading:
                                  MerchantCampaignDetailsController
                                      .to
                                      .contentActionLoading
                                      .value ==
                                  "approve",

                              text: "Approve",

                              onTap: () async {
                                await MerchantCampaignDetailsController.to
                                    .changeContentStatus(
                                      action: "approve",
                                      contentId: data.id,
                                    );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showRejectDialog(
    BuildContext context,
    TextEditingController reasonController,
  ) async {
    final reason = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reject Content",
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Gap(8.h),

                Text(
                  "Please provide a reason for rejecting this submission.",
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),

                Gap(20.h),

                Text(
                  "Rejection Reason",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(8.h),

                TextField(
                  controller: reasonController,
                  maxLines: 4,
                  textInputAction: TextInputAction.newline,

                  decoration: InputDecoration(
                    hintText: "Example: Video quality is not clear",

                    hintStyle: context.bodySmall.copyWith(color: Colors.grey),

                    filled: true,
                    fillColor: AppColors.backgroundColorNew,

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),

                      borderSide: BorderSide(
                        color: AppColors.backgroundsLinesColor,
                      ),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),

                      borderSide: BorderSide(
                        color: AppColors.backgroundsLinesColor,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),

                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),

                Gap(24.h),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 46.h,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),

                            side: BorderSide(color: Colors.grey.shade300),
                          ),

                          child: Text(
                            "Cancel",
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Gap(12.w),

                    Expanded(
                      child: SizedBox(
                        height: 46.h,
                        child: ElevatedButton(
                          onPressed: () {
                            final value = reasonController.text.trim();

                            if (value.isEmpty) {
                              ApiSnackbar.show(
                                "A rejection reason is required so the influencer knows what to improve.",
                              );
                              return;
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),

                          child: Text(
                            "Reject",
                            style: context.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (reason != null && reason.isNotEmpty) {
      await MerchantCampaignDetailsController.to.changeContentStatus(
        action: "reject",
        rejectionReason: reason,
        contentId: data.id,
      );
    }
  }
}
