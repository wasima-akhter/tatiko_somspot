import 'package:som_spot/features/influencer_all/influencer_publish_proof/controller/influencer_publish_proof_controller.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../nav/controller/navigation_controller.dart';
import '../../../success/success_screen.dart';
import '../../core/influencer_tasks/response/influencer_tasks_response.dart';
import '../../influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_task_screen/helper/influencer_task_helper.dart';
import '../../influencer_your_submission/widgets/submission_info_card.dart';
import '../widgets/influencer_status_message_card.dart';
import '../widgets/platform_selector.dart';
import '../widgets/proof_input_card.dart';
import '../widgets/section_tile.dart';

enum PublishProofStage { download, publish, proof }

class InfluencerPublishProofScreen extends StatefulWidget {
  final InfluencerTaskModel task;
  const InfluencerPublishProofScreen({super.key, required this.task});

  @override
  State<InfluencerPublishProofScreen> createState() =>
      _PublishProofScreenState();
}

class _PublishProofScreenState extends State<InfluencerPublishProofScreen> {
  PublishProofStage stage = PublishProofStage.download;

  PlatformType selectedPlatform = PlatformType.tiktok;

  @override
  void initState() {
    super.initState();

    proofController.text = "";

    switch (widget.task.platform?.toLowerCase()) {
      case "instagram":
        selectedPlatform = PlatformType.instagram;
        break;
      case "facebook":
        selectedPlatform = PlatformType.facebook;
        break;
      case "youtube":
        selectedPlatform = PlatformType.youtube;
        break;
      case "twitter":
      case "x":
        selectedPlatform = PlatformType.twitter;
        break;
      case "tiktok":
      default:
        selectedPlatform = PlatformType.tiktok;
    }
  }

  final TextEditingController proofController = TextEditingController();

  @override
  void dispose() {
    proofController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = InfluencerPublishProofController.to;
    return ScaffoldWrapper(
      backgroundColor: Colors.blue.shade50,
      title: AppStrings.publishAndProof.tr,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubmissionInfoCard(task: widget.task),

              SizedBox(height: 16.h),

              StatusMessageCard(
                status: widget.task.status,
                title: widget.task.campaign?.name ?? AppStrings.campaign.tr,
                message: AppStrings.publishApprovedDraftMessage.tr,
              ),

              SizedBox(height: 24.h),

              SectionTitle(title: AppStrings.selectPlatform.tr),

              SizedBox(height: 14.h),

              PlatformSelector(
                selected: selectedPlatform,
                onChanged: (platform) {
                  setState(() {
                    selectedPlatform = platform;
                  });
                },
              ),

              SizedBox(height: 20.h),

              ProofInputCard(
                title: AppStrings.socialMediaPostUrl.tr,
                description: AppStrings.addLivePostLink.tr,
                controller: proofController,
                hintText: _hintForPlatform(),
              ),

              SizedBox(height: 28.h),

              Obx(
                () => CustomButton(
                  text: AppStrings.confirmPublishing.tr,
                  isLoading:
                      controller.submitPostStatus.value == ApiStatus.loading,
                  onTap: () {
                    controller.submitPost(
                      applicationId: widget.task.id,
                      postUrl: proofController.text.trim(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _hintForPlatform() {
    switch (selectedPlatform) {
      case PlatformType.tiktok:
        return "https://tiktok.com/@you/video/...";

      case PlatformType.instagram:
        return "https://instagram.com/p/...";

      case PlatformType.facebook:
        return "https://facebook.com/...";

      case PlatformType.youtube:
        return "https://youtube.com/watch?v=...";

      case PlatformType.twitter:
        return "https://x.com/username/status/...";
    }
  }

  void _submitPublishing() {
    AppRouter.route.goNamed(
      RoutePath.successScreen,
      extra: SuccessScreenArgs(
        title: AppStrings.publishingConfirmed.tr,
        subtitle: AppStrings.campaignMovedToPublished.tr,
        autoNavigateAfter: const Duration(seconds: 3),
        onAutoNavigate: () {
          AppRouter.route.goNamed(RoutePath.navigationPages);

          if (Get.isRegistered<NavigationControllerMain>()) {
            print('going to tasks tab');

            NavigationControllerMain.to.goToTabTasks();

            if (Get.isRegistered<InfluencerTaskController>()) {
              print('going to tasks tab > published tab');

              InfluencerTaskController.to.selectedTab.value =
                  InfluencerTaskTab.published;
            }
          }
        },
      ),
    );
  }
}
