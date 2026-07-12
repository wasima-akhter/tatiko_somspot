import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/router/route_path.dart';
import '../../../../core/router/routes.dart';
import '../../../../share/widgets/button/custom_button.dart';
import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import '../../../nav/controller/navigation_controller.dart';
import '../../../success/success_screen.dart';
import '../../influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_your_submission/widgets/submission_info_card.dart';
import '../widgets/influencer_publish_proof_sec.dart';
import '../widgets/influencer_status_message_card.dart';
import '../widgets/page_container.dart';
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
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade50,
        title: const Text("Publish & Proof"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfluencerPublishProof(currentStep: _currentStep),

              SizedBox(height: 20.h),

              const SubmissionInfoCard(),

              SizedBox(height: 14.h),

              _buildStageStatus(),

              SizedBox(height: 24.h),

              const SectionTitle(title: "Choose a platform to publish on"),

              SizedBox(height: 14.h),

              _buildStageContent(),
            ],
          ),
        ),
      ),
    );
  }

  int get _currentStep {
    switch (stage) {
      case PublishProofStage.download:
        return 1;
      case PublishProofStage.publish:
        return 2;
      case PublishProofStage.proof:
        return 3;
    }
  }

  Widget _buildStageStatus() {
    switch (stage) {
      case PublishProofStage.download:
        return const StatusMessageCard(
          title: "Merchant approval note",
          message:
              "Looks fantastic — the BOGO call-out is crystal clear. Approved! Download the final cut and post it on TikTok.",
          backgroundColor: Color(0xffF1FFF4),
          borderColor: Color(0xffD5F4DC),
        );

      case PublishProofStage.publish:
        return const StatusMessageCard(
          title: "Content downloaded",
          message: "",
          icon: Icons.check_circle_outline,
          backgroundColor: Color(0xffF1FFF4),
          borderColor: Color(0xffD5F4DC),
        );

      case PublishProofStage.proof:
        return const ProofInputCard(
          title: "Proof of publication",
          description:
              "Paste the live TikTok post URL so the merchant can verify engagement.",
        );
    }
  }

  Widget _buildStageContent() {
    switch (stage) {
      case PublishProofStage.download:
        return _downloadView();

      case PublishProofStage.publish:
        return _publishView();

      case PublishProofStage.proof:
        return _proofView();
    }
  }

  Widget _downloadView() {
    return PageContainer(
      child: Column(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: const BoxDecoration(
              color: Color(0xffEAF8EE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.file_download_outlined,
              color: AppColors.emeraldGreenColor,
              size: 34,
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            "Approved content ready",
            style: context.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          Text(
            "Download the final approved file, then publish it to your channel.",
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: AppColors.grayTextSecondaryColor,
            ),
          ),
          SizedBox(height: 24.h),
          CustomButton(
            text: "Download Content",
            icon: Icons.download,
            backgroundColor: AppColors.emeraldGreenColor,
            onTap: () {
              setState(() {
                stage = PublishProofStage.publish;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _publishView() {
    return Column(
      children: [
        PlatformSelector(
          selected: selectedPlatform,
          onChanged: (platform) {
            setState(() {
              selectedPlatform = platform;
            });
          },
        ),
        SizedBox(height: 16.h),
        const StatusMessageCard(
          title: "Open TikTok to post",
          message:
              "Upload your downloaded content with the approved caption, then come back here to submit the live link.",
          icon: Icons.open_in_new,
          backgroundColor: Color(0xffF8F0FF),
          borderColor: Color(0xffE8D8FF),
        ),
        SizedBox(height: 22.h),
        CustomButton(text: "Open TikTok App", onTap: () {}),
        SizedBox(height: 14.h),
        CustomButton(
          text: "I've Posted — Submit Link",
          isOutlined: true,
          onTap: () {
            setState(() {
              stage = PublishProofStage.proof;
            });
          },
        ),
      ],
    );
  }

  Widget _proofView() {
    return Column(
      children: [
        TextField(
          controller: proofController,
          decoration: InputDecoration(
            hintText: "https://tiktok.com/@you/video/...",
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 15.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: AppColors.backgroundsLinesColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(color: AppColors.backgroundsLinesColor),
            ),
          ),
        ),
        SizedBox(height: 22.h),
        CustomButton(
          text: "Submit Proof Link",
          onTap: () {
            AppRouter.route.goNamed(
              RoutePath.successScreen,
              extra: SuccessScreenArgs(
                title: "Proof Submitted!",
                subtitle:
                    "We're verifying your post's\nengagement against the\ncampaign target. Your task\nis now in \"Verifying\".",
                autoNavigateAfter: const Duration(seconds: 3),
                onAutoNavigate: () {
                  AppRouter.route.goNamed(RoutePath.navigationPages);
                  if (Get.isRegistered<NavigationControllerMain>()) {
                    NavigationControllerMain.to.goToTabTasks();
                    if (Get.isRegistered<InfluencerTaskController>()) {
                      InfluencerTaskController.to.selectedTab.value = 1;
                    }
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
