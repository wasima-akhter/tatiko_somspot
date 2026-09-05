import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:som_spot/features/auth/controller/auth_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/dropdown/custom_dropdown_field.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../helper/snackbar/app_snackbar.dart';
import '../../../utils/common_controller/common_controller.dart';
import '../../../utils/enum/app_enum.dart';

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

    if (kDebugMode) {
      _nameController.text = "abc";
      _phoneController.text = "01265465454";
      _emailController.text = "abc@yopmail.com";
      _passwordController.text = "123456";
      _confirmPasswordController.text = "123456";
    }
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
    final controller = AuthController.to;
    final commonController = CommonController.to;

    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      onPressed: () => AppRouter.route.pop(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Gap(16),

              // // ── Back Button ──
              // GestureDetector(
              //   behavior: HitTestBehavior.opaque,
              //   onTap: () => AppRouter.route.pop(),
              //   child: const Icon(
              //     Icons.arrow_back_ios_new,
              //     color: AppColors.darkTextColor,
              //     size: 20,
              //   ),
              // ),

              // const Gap(24),

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
                        // ── Role ──
                        Text(
                          'Role',
                          style: context.bodyMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkTextColor,
                          ),
                        ),
                        const Gap(8),

                        Obx(
                          () => CustomDropdownField<UserRole>(
                            hintText: 'Select your role',
                            items: commonController.roles,
                            value: commonController.role.value,
                            isRequired: true,
                            labelBuilder: (role) {
                              switch (role) {
                                case UserRole.customer:
                                  return AppStrings.customer.tr;
                                case UserRole.merchandiser:
                                  return AppStrings.merchant.tr;
                                case UserRole.influencer:
                                  return AppStrings.influencer.tr;
                              }
                            },
                            onChanged: commonController.setRole,
                          ),
                        ),

                        const Gap(16),

                        // ── Full Name ──
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

                        // ── Phone ──
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

                        // ── Email ──
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

                        // ── Password ──
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

                        // ── Confirm Password ──
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
                        Obx(
                          () => controller.isRegisterLoading.value
                              ? LoadingWidget()
                              : CustomButton(
                                  text: AppStrings.createAccount.tr,
                                  onTap: _validateAndRegister,
                                ),
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

  void _validateAndRegister() {
    final commonController = CommonController.to;
    final controller = AuthController.to;

    // ── Full Name ──
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      UiSnackbar.show(
        context,
        title: 'Name Required',
        message: 'Please enter your full name',
        type: UiSnackbarType.warning,
      );
      return;
    }

    if (name.length < 2) {
      UiSnackbar.show(
        context,
        title: 'Invalid Name',
        message: 'Please enter a valid full name',
        type: UiSnackbarType.warning,
      );
      return;
    }

    // ── Phone ──
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      UiSnackbar.show(
        context,
        title: 'Phone Required',
        message: 'Please enter your phone number',
        type: UiSnackbarType.warning,
      );
      return;
    }

    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone)) {
      UiSnackbar.show(
        context,
        title: 'Invalid Phone',
        message: 'Please enter a valid phone number',
        type: UiSnackbarType.warning,
      );
      return;
    }

    // ── Email ──
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      UiSnackbar.show(
        context,
        title: 'Email Required',
        message: 'Please enter your email address',
        type: UiSnackbarType.warning,
      );
      return;
    }

    if (!RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email)) {
      UiSnackbar.show(
        context,
        title: 'Invalid Email',
        message: 'Please enter a valid email address',
        type: UiSnackbarType.warning,
      );
      return;
    }

    // ── Password ──
    final password = _passwordController.text;

    if (password.isEmpty) {
      UiSnackbar.show(
        context,
        title: 'Password Required',
        message: 'Please enter a password',
        type: UiSnackbarType.warning,
      );
      return;
    }

    if (password.length < 6) {
      UiSnackbar.show(
        context,
        title: 'Invalid Password',
        message: 'Password must be at least 6 characters',
        type: UiSnackbarType.warning,
      );
      return;
    }

    // ── Confirm Password ──
    final confirmPassword = _confirmPasswordController.text;

    if (confirmPassword.isEmpty) {
      UiSnackbar.show(
        context,
        title: 'Confirm Password',
        message: 'Please confirm your password',
        type: UiSnackbarType.warning,
      );
      return;
    }

    if (password != confirmPassword) {
      UiSnackbar.show(
        context,
        title: 'Password Mismatch',
        message: 'Passwords do not match',
        type: UiSnackbarType.warning,
      );
      return;
    }

    // ── Terms & Privacy ──
    if (!_agreedToTerms) {
      UiSnackbar.show(
        context,
        title: 'Terms Required',
        message: 'Please accept terms and privacy policy',
        type: UiSnackbarType.warning,
      );
      return;
    }

    // ── API ──
    controller.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      role: commonController.role.value.value,
    );
  }
}
