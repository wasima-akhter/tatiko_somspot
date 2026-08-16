import 'package:som_spot/features/merchant/merchant_campaign_details/controller/merchant_campaign_details_controller.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../share/widgets/video/video_overlay.dart';
import '../widgets/merchant_campaign_content_preview_card.dart';

class MerchantCampaignContentDetailsScreen extends StatefulWidget {
  final String contentId;
  const MerchantCampaignContentDetailsScreen({
    super.key,
    required this.contentId,
  });

  @override
  State<MerchantCampaignContentDetailsScreen> createState() =>
      _MerchantCampaignContentDetailsScreenState();
}

class _MerchantCampaignContentDetailsScreenState
    extends State<MerchantCampaignContentDetailsScreen> {
  late final MerchantCampaignDetailsController controller;

  @override
  void initState() {
    super.initState();

    controller = MerchantCampaignDetailsController.to;

    controller.loadContentDetails(widget.contentId);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: AppStrings.contentDetails.tr,
      onPressed: () {
        AppRouter.route.pop();
      },

      body: Obx(
        () => ApiStatusBuilder(
          status: controller.contentDetailStatus.value,

          errorMessage: controller.errorMessage.value,

          onRetry: () => controller.loadContentDetails(widget.contentId),

          builder: (_) {
            final data = controller.contentDetail.value!;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),

              child: MerchantCampaignContentPreviewCard(
                storeName: data.creator.name,
                storeImage: data.creator.profileImage,

                title: AppStrings.submittedContent.tr,

                description: data.caption?.capitalizeFirst ?? '',

                platform: data.platform ?? '',

                videoUrl: data.draftVideoUrl,

                thumbnail: data.thumbnail, // if available

                status: data.status
                    .replaceAll('_', ' ')
                    .capitalizeWords(), // if available

                category: data.draftMediaType, // if available

                submittedDate:
                    "${DateConverter.formatDate(dateTime: data.createdAt)}, ${DateConverter.formatTime(dateTime: data.createdAt)}",

                onPlay: () {
                  if (data.draftVideoUrl != null &&
                      data.draftVideoUrl!.isNotEmpty) {
                    AppVideoOverlay.show(
                      context,
                      videoUrl: data.draftVideoUrl!,
                      title: AppStrings.submittedContent.tr,
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
