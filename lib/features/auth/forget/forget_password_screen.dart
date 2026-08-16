import 'package:som_spot/helper/validator/text_field_validator.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../controller/auth_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              // ── Back Button ──
              GestureDetector(
                behavior: HitTestBehavior.opaque,
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
                AppStrings.forgotPasswordTitle.tr,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              const Gap(8),

              // ── Subtitle ──
              Text(
                AppStrings.forgotPasswordSubtitle.tr,
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
                          validator: TextFieldValidator.email(),
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
                        const Gap(40),

                        // ── Send Code Button ──
                        Obx(
                          () => AuthController.to.isLoading.value
                              ? LoadingWidget()
                              : CustomButton(
                                  text: AppStrings.sendVerificationCode.tr,
                                  onTap: () {
                                    if (!_formKey.currentState!.validate())
                                      return;

                                    AuthController.to.forgotPassword(
                                      email: _emailController.text.trim(),
                                    );
                                  },
                                ),
                        ),
                        const Gap(24),

                        // // ── Remembered password? Log In ──
                        // Center(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       SizedBox(
                        //         height: 20,
                        //         width: 20,
                        //         child: Checkbox(
                        //           value:
                        //               false, // In image it's unchecked but it's just a visual, usually not a real checkbox for navigation
                        //           onChanged: (val) {},
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(4),
                        //           ),
                        //           side: const BorderSide(
                        //             color: AppColors.hintTextColor,
                        //           ),
                        //         ),
                        //       ),
                        //       const Gap(8),
                        //       RichText(
                        //         text: TextSpan(
                        //           style: context.bodyMedium.copyWith(
                        //             color: AppColors.subtitleTextColor,
                        //           ),
                        //           children: [
                        //             TextSpan(
                        //               text:
                        //                   '${AppStrings.rememberedPassword.tr} ',
                        //             ),
                        //             TextSpan(
                        //               text: AppStrings.logIn.tr,
                        //               style: const TextStyle(
                        //                 color: AppColors.primaryColor,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //               recognizer: TapGestureRecognizer()
                        //                 ..onTap = () {
                        //                   AppRouter.route.goNamed(
                        //                     RoutePath.loginScreen,
                        //                   );
                        //                 },
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
