import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    // Initialize common controller state
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              // ── Back Button ──
              GestureDetector(
                onTap: () => AppRouter.route.pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.darkTextColor,
                  size: 20,
                ),
              ),
              const Gap(24),

              // ── Title ──
              Text(
                AppStrings.createAccount.tr,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              const Gap(8),

              // ── Subtitle ──
              Text(
                AppStrings.joinSomSpot.tr,
                style: context.bodyLarge.copyWith(
                  color: AppColors.subtitleTextColor,
                  height: 1.5,
                ),
              ),
              const Gap(24),

              // ── Form ──
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          title: AppStrings.fullName.tr,
                          hintText: AppStrings.ahmedMohamed.tr,
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            size: 20,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        const Gap(16),

                        CustomTextField(
                          controller: _phoneController,
                          title: AppStrings.phoneNumber.tr,
                          hintText: AppStrings.examplePhone.tr,
                          keyboardType: TextInputType.phone,
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            size: 20,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        const Gap(16),

                        CustomTextField(
                          controller: _emailController,
                          title: AppStrings.email.tr,
                          hintText: AppStrings.exampleMail.tr,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 20,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        const Gap(16),

                        CustomTextField(
                          controller: _passwordController,
                          title: AppStrings.password.tr,
                          hintText: '**********',
                          isPassword: true,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            size: 20,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        const Gap(16),

                        CustomTextField(
                          controller: _confirmPasswordController,
                          title: AppStrings.confirmPassword.tr,
                          hintText: '**********',
                          isPassword: true,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            size: 20,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        const Gap(24),

                        // ── Terms & Privacy ──
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: _agreedToTerms,
                                onChanged: (val) {
                                  setState(() {
                                    _agreedToTerms = val ?? false;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                activeColor: AppColors.primaryColor,
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: context.bodyMedium.copyWith(
                                    color: AppColors.subtitleTextColor,
                                    height: 1.4,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${AppStrings.agreeToSomspot.tr} ',
                                    ),
                                    TextSpan(
                                      text: AppStrings.termsOfService.tr,
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                    TextSpan(text: ' ${AppStrings.and.tr} '),
                                    TextSpan(
                                      text: AppStrings.privacyPolicy.tr,
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(32),

                        // ── Create Account Button ──
                        CustomButton(
                          text: AppStrings.createAccount.tr,
                          onTap: () {
                            AppRouter.route.pushNamed(
                              RoutePath.activeOtpScreen,
                              extra: _emailController.text,
                            );
                          },
                        ),
                        const Gap(24),

                        // ── Already have an account? Log In ──
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: context.bodyMedium.copyWith(
                                color: AppColors.subtitleTextColor,
                              ),
                              children: [
                                TextSpan(
                                  text: '${AppStrings.alreadyHaveAccount.tr} ',
                                ),
                                TextSpan(
                                  text: AppStrings.logIn.tr,
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      AppRouter.route.goNamed(
                                        RoutePath.loginScreen,
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
}
