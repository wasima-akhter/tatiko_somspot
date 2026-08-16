import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings/app_strings.dart';
import '../widgets/influencer_progress_step.dart';

class InfluencerPublishProof extends StatelessWidget {
  final int currentStep;

  const InfluencerPublishProof({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ProgressStep(
            title: AppStrings.download.tr,
            number: 1,
            isCompleted: currentStep > 1,
            isCurrent: currentStep == 1,
            showLeftLine: false,
            showRightLine: true,
          ),
        ),
        Expanded(
          child: ProgressStep(
            title: AppStrings.pleaseEnterSocialMediaPostUrl.tr,
            number: 2,
            isCompleted: currentStep > 2,
            isCurrent: currentStep == 2,
            showLeftLine: true,
            showRightLine: true,
          ),
        ),
        Expanded(
          child: ProgressStep(
            title: AppStrings.proof.tr,
            number: 3,
            isCompleted: false,
            isCurrent: currentStep == 3,
            showLeftLine: true,
            showRightLine: false,
          ),
        ),
      ],
    );
  }
}
