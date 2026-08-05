import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/utils/api_urls/api_urls.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../share/controller/screen_export.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_model.dart';
import '../controller/merchant_campaign_details_controller.dart';

class MerchantCampaignPublishedCard extends StatelessWidget {
  final CampaignContentModel data;

  const MerchantCampaignPublishedCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final controller = MerchantCampaignDetailsController.to;

    final videoUrl = getVideoUrl(data.draftVideoUrl, ApiUrls.base);

    debugPrint('videoUrl: $videoUrl');
    final status = data.status;

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14.r,
                child: CustomNetworkImage(
                  imageUrl: data.creator.profileImage ?? "",
                  boxShape: BoxShape.circle,
                ),
              ),

              SizedBox(width: 8.w),

              Expanded(
                child: Text(
                  "@${data.creator.name ?? "creator"}",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Text(
                data.platform ?? "",
                style: context.bodySmall.copyWith(
                  color: AppColors.subtitleTextColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          GestureDetector(
            onTap: () => _launchUrl(videoUrl),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),

              decoration: BoxDecoration(
                color: const Color(0xffF7F0FF),
                borderRadius: BorderRadius.circular(8.r),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      videoUrl,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: context.bodySmall.copyWith(
                        color: AppColors.purpleAccentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Icon(
                    Icons.open_in_new,
                    size: 16.sp,
                    color: AppColors.purpleAccentColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),

          if (status == "approved")
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      controller.verifyPublication(
                        applicationId: data.id,
                        action: "reject",
                      );
                    },

                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),

                    child: Obx(
                      () =>
                          controller.publicationActionLoading.value == "reject"
                          ? LoadingWidget()
                          : const Text(
                              "Reject",
                              style: TextStyle(color: Colors.red),
                            ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.verifyPublication(
                        applicationId: data.id,
                        action: "approve",
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),

                    child: Obx(
                      () =>
                          controller.publicationActionLoading.value == "arrpove"
                          ? LoadingWidget()
                          : const Text(
                              "Approve",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String getVideoUrl(String? videoUrl, String baseUrl) {
    if (videoUrl == null || videoUrl.trim().isEmpty) {
      return '';
    }

    var url = videoUrl.trim();

    url = url.replaceAll("\\", "/");

    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }

    return '${baseUrl.replaceAll(RegExp(r'/$'), '')}/${url.replaceFirst(RegExp(r'^/'), '')}';
  }

  Future<void> _launchUrl(String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.tryParse(url);

    if (uri == null) return;

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
