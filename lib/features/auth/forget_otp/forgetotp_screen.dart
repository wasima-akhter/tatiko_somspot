import 'dart:async';

import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/text_field/otp_text_field.dart';

import '../../../share/widgets/loading/loading_widget.dart';
import '../controller/auth_controller.dart';

class ForgetOtpScreen extends StatefulWidget {
  final String? email;
  const ForgetOtpScreen({super.key, this.email});

  @override
  State<ForgetOtpScreen> createState() => _ForgetOtpScreenState();
}

class _ForgetOtpScreenState extends State<ForgetOtpScreen> {
  final _pinController = TextEditingController();

  Timer? _timer;
  int _seconds = 33;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();

    _seconds = 33;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  String get _formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
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
                AppStrings.verifyYourEmail.tr,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              const Gap(8),

              // ── Subtitle ──
              RichText(
                text: TextSpan(
                  style: context.bodyLarge.copyWith(
                    color: AppColors.subtitleTextColor,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: '${AppStrings.weSentCode.tr} '),
                    TextSpan(
                      text: widget.email ?? 'example@mail.com',
                      style: const TextStyle(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(40),

              // ── Form ──
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.enterVerificationCode.tr,
                        style: context.bodyLarge.copyWith(
                          color: AppColors.darkTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(16),

                      // ── Pinput ──
                      Align(
                        alignment: Alignment.center,
                        child: OtpTextField(controller: _pinController),
                      ),

                      const Gap(24),

                      // ── Resend Code ──
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: context.bodyMedium.copyWith(
                              color: AppColors.subtitleTextColor,
                            ),
                            children: [
                              TextSpan(text: '${AppStrings.resendCodeIn.tr} '),
                              TextSpan(
                                text: _formattedTime,
                                style: const TextStyle(
                                  color: AppColors.darkTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(30),

                      // ── Verify & Continue Button ──
                      Obx(
                        () => AuthController.to.isLoading.value
                            ? LoadingWidget()
                            : CustomButton(
                                text: AppStrings.verifyAndContinue.tr,
                                onTap: () {
                                  if (_pinController.text.trim().isEmpty) {
                                    return;
                                  }

                                  AuthController.to.verifyForgotPasswordOtp(
                                    email: widget.email ?? '',
                                    code: _pinController.text.trim(),
                                  );
                                },
                              ),
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
