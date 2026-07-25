import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/auth/intro/onboarding/model/onboarding_model.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class OnboardingPageCard extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPageCard({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Image ──
          Expanded(
            flex: 6,
            child: Center(
              child: Container(
                // color: Colors.amber,
                child: Image.asset(model.image, fit: BoxFit.contain),
              ),
            ),
          ),
          const Gap(6),
          // ── Title ──
          Text(
            model.title.tr,
            style: context.headlineMedium.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(16),

          // ── Subtitle ──
          Text(
            model.details.tr,
            style: context.bodyLarge.copyWith(
              color: AppColors.subtitleTextColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(24),
        ],
      ),
    );
  }
}
