import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/custom_assets/assets.gen.dart';
import 'package:som_spot/features/auth/intro/onboarding/model/onboarding_model.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../../utils/common_controller/common_controller.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();

  // Built once, from whatever role was set before this screen opened.
  late final List<OnboardingModel> onboardingList = _buildOnboardingList();

  List<OnboardingModel> _buildOnboardingList() {
    return CommonController.to.isInfluencer
        ? _influencerOnboarding
        : _defaultOnboarding; // merchandiser + customer share this
  }

  static final List<OnboardingModel> _defaultOnboarding = [
    OnboardingModel(
      image: Assets.images.onboardone.path,
      title: AppStrings.onboardingOne,
      details: AppStrings.onboardingSubtitleOne,
    ),
    OnboardingModel(
      image: Assets.images.onboardtwo.path,
      title: AppStrings.onboardingTwo,
      details: AppStrings.onboardingSubtitleTwo,
    ),
    OnboardingModel(
      image: Assets.images.onboardthree.path,
      title: AppStrings.onboardingThree,
      details: AppStrings.onboardingSubtitleThree,
    ),
  ];

  static final List<OnboardingModel> _influencerOnboarding = [
    OnboardingModel(
      image: Assets.images.influencerOnboardOne.path,
      title: AppStrings.monetizeYourAudience,
      details: AppStrings.partnerDescription,
    ),
    OnboardingModel(
      image: Assets.images.influencerOnboardTwo.path,
      title: AppStrings.createAndShare,
      details: AppStrings.campaignsDescription,
    ),
    OnboardingModel(
      image: Assets.images.influencerOnboardThree.path,
      title: AppStrings.trackEarnings,
      details: AppStrings.commissionsDescription,
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
