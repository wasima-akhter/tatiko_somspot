import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../../../share/widgets/loading/loading_widget.dart';
import '../controller/auth_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email;

  const ResetPasswordScreen({super.key, this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
                AppStrings.createNewPassword.tr,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              const Gap(8),

              // ── Subtitle ──
              Text(
                AppStrings.createNewPasswordSubtitle.tr,
                style: context.bodyLarge.copyWith(
                  color: AppColors.subtitleTextColor,
                  height: 1.5,
                ),
              ),
              const Gap(40),

              // ── Form ──
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const Gap(40),

                        // ── Save Password Button ──
                        Obx(
                          () => AuthController.to.isLoading.value
                              ? LoadingWidget()
                              : CustomButton(
                                  text: AppStrings.savePassword.tr,
                                  onTap: () {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    AuthController.to.resetPassword(
                                      email: widget.email ?? '',
                                      password: _passwordController.text.trim(),
                                      confirmPassword:
                                          _confirmPasswordController.text
                                              .trim(),
                                    );
                                  },
                                ),
                        ),
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
}
