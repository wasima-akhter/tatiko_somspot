import '../../../../share/controller/screen_export.dart';
import '../../../nav/controller/navigation_controller.dart';
import '../../../success/success_screen.dart';
import '../../influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_task_screen/helper/influencer_task_helper.dart';
import '../../influencer_your_submission/widgets/submission_info_card.dart';
import '../widgets/influencer_status_message_card.dart';
import '../widgets/platform_selector.dart';
import '../widgets/proof_input_card.dart';
import '../widgets/section_tile.dart';

enum PublishProofStage { download, publish, proof }

class InfluencerPublishProofScreen extends StatefulWidget {
  const InfluencerPublishProofScreen({super.key});

  @override
  State<InfluencerPublishProofScreen> createState() =>
      _PublishProofScreenState();
}

class _PublishProofScreenState extends State<InfluencerPublishProofScreen> {
  PublishProofStage stage = PublishProofStage.download;

  PlatformType selectedPlatform = PlatformType.tiktok;

  final TextEditingController proofController = TextEditingController();

  @override
  void dispose() {
    proofController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: Colors.blue.shade50,
      title: "Publish & Proof",
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SubmissionInfoCard(),

              SizedBox(height: 16.h),

              StatusMessageCard(
                status: "Merchant approved",
                title: "Family Feast Promo",
                message:
                    "Choose where you published this content, then confirm to move the campaign to Published.",
              ),

              SizedBox(height: 24.h),

              const SectionTitle(title: "Select platform"),

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
                title: "Social media post URL",
                description:
                    "Add the live post link now, or return later to include it.",
                controller: proofController,
                hintText: _hintForPlatform(),
              ),

              SizedBox(height: 28.h),

              CustomButton(
                text: "Confirm Publishing",
                onTap: _submitPublishing,
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
        title: "Publishing Confirmed!",
        subtitle:
            "Your campaign has been moved to Published. We'll verify your live post shortly.",
        autoNavigateAfter: const Duration(seconds: 3),
        onAutoNavigate: () {
          AppRouter.route.goNamed(RoutePath.navigationPages);

          if (Get.isRegistered<NavigationControllerMain>()) {
            debugPrint('going to tasks tab');
            NavigationControllerMain.to.goToTabTasks();

            if (Get.isRegistered<InfluencerTaskController>()) {
              debugPrint('going to tasks tab > published tab');
              InfluencerTaskController.to.selectedTab.value =
                  InfluencerTaskTab.published;
            }
          }
        },
      ),
    );
  }
}
