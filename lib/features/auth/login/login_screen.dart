import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:som_spot/features/auth/core/requests/auth_request.dart';
import 'package:som_spot/helper/validator/text_field_validator.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      _emailController.text = "abc@yopmail.com";
      _passwordController.text = "123456";
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.to;
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),

              // ── Title ──
              Text(
                AppStrings.welcomeBack.tr,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              const Gap(8),

              // ── Subtitle ──
              Text(
                AppStrings.loginToAccount.tr,
                style: context.bodyLarge.copyWith(
                  color: AppColors.subtitleTextColor,
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
                          validator: TextFieldValidator.email(),
                          controller: _emailController,
                          title: AppStrings.emailOrPhone.tr,
                          hintText: AppStrings.enterEmailOrPhone.tr,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 20,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                        const Gap(24),

                        CustomTextField(
                          // validator: TextFieldValidator.password(),
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

                        // ── Forgot Password ──
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              AppRouter.route.pushNamed(
                                RoutePath.forgetPasswordScreen,
                              );
                            },
                            child: Text(
                              AppStrings.forgotPassword.tr,
                              style: context.bodyMedium.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const Gap(40),

                        // ── Log In Button ──
                        Obx(
                          () => CustomButton(
                            text: AppStrings.logIn.tr,
                            isLoading: controller.isLoading.value,
                            onTap: controller.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.login(
                                        request: LoginRequest(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text
                                              .trim(),
                                        ),
                                      );
                                    }
                                  },
                          ),
                        ),
                        const Gap(24),

                        // ── Don't have an account? Sign Up ──
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: context.bodyMedium.copyWith(
                                color: AppColors.subtitleTextColor,
                              ),
                              children: [
                                TextSpan(
                                  text: '${AppStrings.dontHaveAccount.tr} ',
                                ),
                                TextSpan(
                                  text: AppStrings.signUp.tr,
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      AppRouter.route.pushNamed(
                                        RoutePath.signUpScreen,
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
}
