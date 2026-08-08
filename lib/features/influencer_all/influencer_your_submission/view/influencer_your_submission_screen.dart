import 'package:som_spot/features/merchant/merchant_campaign_details/widgets/merchant_campaign_content_preview_card.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../share/widgets/video/video_overlay.dart';
import '../../influencer_task_screen/controller/influencer_task_controller.dart';
import '../args/influencer_submission_args.dart';
import '../widgets/back_to_tasks_button.dart';
import '../widgets/verification_banner.dart';

class InfluencerYourSubmissionScreen extends StatefulWidget {
  final InfluencerSubmissionArgs influencerSubmissionArgs;

  const InfluencerYourSubmissionScreen({
    super.key,
    required this.influencerSubmissionArgs,
  });

  @override
  State<InfluencerYourSubmissionScreen> createState() =>
      _InfluencerYourSubmissionScreenState();
}

class _InfluencerYourSubmissionScreenState
    extends State<InfluencerYourSubmissionScreen> {
  final controller = InfluencerTaskController.to;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadTaskDetail(widget.influencerSubmissionArgs.applicationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      title: AppStrings.yourSubmission.tr,
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ApiStatusBuilder(
                status: controller.taskDetailStatus.value,
                errorMessage: controller.taskDetailError,
                onRetry: () {
                  controller.loadTaskDetail(
                    widget.influencerSubmissionArgs.applicationId,
                  );
                },
                builder: (_) {
                  final task = controller.taskDetail.value;

                  if (task == null) {
                    return const SizedBox();
                  }

                  debugPrint('draftVideoUrl: ${task.draftVideoUrl}');

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerificationBanner(
                          status: widget.influencerSubmissionArgs.status,
                        ),

                        SizedBox(height: 14.h),

                        MerchantCampaignContentPreviewCard(
                          storeImage: task.campaign?.business?.logo ?? "",

                          thumbnail: task.thumbnail,

                          videoUrl: task.draftVideoUrl ?? "",

                          storeName:
                              task.campaign?.business?.name ??
                              AppStrings.unknownStore.tr,

                          title:
                              task.campaign?.name ??
                              AppStrings.campaignContent.tr,

                          description: task.caption?.isNotEmpty == true
                              ? task.caption!
                              : task.campaign?.about ?? "",

                          platform:
                              task.platform ??
                              task.campaign?.contentType ??
                              AppStrings.unknown.tr,

                          duration: task.campaign?.videoLengthSec != null
                              ? "${task.campaign!.videoLengthSec}s"
                              : null,

                          status: task.status.isNotEmpty
                              ? task.status
                                    .replaceAll("_", " ")
                                    .capitalizeWords()
                              : null,

                          category: task.campaign?.contentType,

                          submittedDate: DateConverter.formatDate(
                            dateTime: task.submittedAt,
                          ),

                          views: null,

                          onPlay: () {
                            final video = task.draftVideoUrl;

                            if (video != null && video.isNotEmpty) {
                              AppVideoOverlay.show(
                                context,
                                videoUrl: video,
                                title:
                                    task.campaign?.name ??
                                    AppStrings.submittedContent.tr,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          const BackToTasksButton(),
        ],
      ),
    );
  }
}
