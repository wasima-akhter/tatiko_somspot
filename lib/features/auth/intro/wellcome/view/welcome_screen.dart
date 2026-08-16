import 'package:flutter/gestures.dart';
import 'package:som_spot/core/custom_assets/assets.gen.dart';
import 'package:som_spot/share/export/screen_export.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // ── Logo ──
              Center(
                child: Image.asset(
                  Assets.images.splashlogo.path,
                  width: 150, // Adjust based on your asset size
                  fit: BoxFit.contain,
                ),
              ),
              const Gap(32),

              // ── Title ──
              Text(
                AppStrings.welcomeToSomSpot.tr,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(16),

              // ── Subtitle ──
              Text(
                AppStrings.welcomeSubtitle.tr,
                style: context.bodyLarge.copyWith(
                  color: AppColors.subtitleTextColor,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(48),

              // ── Log In Button ──
              CustomButton(
                text: AppStrings.logIn.tr,
                onTap: () {
                  AppRouter.route.goNamed(RoutePath.loginScreen);
                },
              ),
              const Gap(16),

              // ── Create Account Button (Outlined) ──
              CustomButton(
                text: AppStrings.createAnAccount.tr,
                isOutlined: true,
                onTap: () {
                  AppRouter.route.goNamed(RoutePath.signUpScreen);
                },
              ),

              const Spacer(),

              // ── Terms and Privacy Policy ──
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: context.labelMedium.copyWith(
                      color: AppColors.subtitleTextColor,
                      height: 1.5,
                    ),
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.check_box_outlined,
                            size: 16,
                            color: AppColors.subtitleTextColor,
                          ),
                        ),
                        alignment: PlaceholderAlignment.middle,
                      ),
                      TextSpan(text: '${AppStrings.byContinuing.tr} '),
                      TextSpan(
                        text: AppStrings.termsOfService.tr,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to Terms of Service
                          },
                      ),
                      TextSpan(text: ' ${AppStrings.and.tr} '),
                      TextSpan(
                        text: AppStrings.privacyPolicy.tr,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to Privacy Policy
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
