import 'dart:async';

import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/text_field/otp_text_field.dart';

import '../../../helper/snackbar/api_snackbar.dart';
import '../controller/auth_controller.dart';

class ActiveOtpScreen extends StatefulWidget {
  final String? email;

  const ActiveOtpScreen({super.key, this.email});

  @override
  State<ActiveOtpScreen> createState() => _ActiveOtpScreenState();
}

class _ActiveOtpScreenState extends State<ActiveOtpScreen> {
  final _pinController = TextEditingController();

  final AuthController controller = Get.find<AuthController>();

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

  bool get _canResend => _seconds == 0;
  Future<void> _resendOtp() async {
    if (!_canResend) return;

    final email = widget.email?.trim() ?? "";
    if (email.isEmpty) {
      ApiSnackbar.show(
        "Email is missing. Please restart registration.",
        type: SnackbarType.error,
      );
      return;
    }

    await controller.resendOtp(email: email);

    // restart the countdown regardless of outcome, so the user
    // can't spam-tap while the previous request is in flight or failed
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();

    super.dispose();
  }

  void _verifyOtp() {
    final otp = _pinController.text.trim();

    if (otp.length < 4) {
      ApiSnackbar.show(
        "Please enter the verification code",
        type: SnackbarType.warning,
      );
      return;
    }

    final email = widget.email?.trim() ?? "";

    if (email.isEmpty) {
      ApiSnackbar.show(
        "Email is missing. Please restart registration.",
        type: SnackbarType.error,
      );
      return;
    }

    controller.verifyRegisterOtp(email: email, otp: otp);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      onPressed: () => AppRouter.route.pop(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Gap(16),

              Text(
                AppStrings.verifyYourEmail.tr,

                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,

                  color: AppColors.darkTextColor,
                ),
              ),

              const Gap(8),

              RichText(
                text: TextSpan(
                  style: context.bodyLarge.copyWith(
                    color: AppColors.subtitleTextColor,

                    height: 1.5,
                  ),

                  children: [
                    TextSpan(text: '${AppStrings.weSentCode.tr} '),

                    TextSpan(
                      text: widget.email ?? "example@mail.com",

                      style: const TextStyle(
                        color: AppColors.darkTextColor,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(40),

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

                      Align(
                        alignment: Alignment.center,

                        child: OtpTextField(controller: _pinController),
                      ),

                      const Gap(24),
                      // ── Resend row: countdown OR tappable resend ──
                      Center(
                        child: Obx(() {
                          if (controller.isResendingOtp.value) {
                            return const SizedBox(
                              height: 18,
                              width: 18,
                              child: LoadingWidget(),
                            );
                          }

                          if (!_canResend) {
                            return RichText(
                              text: TextSpan(
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.subtitleTextColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${AppStrings.resendCodeIn.tr} ',
                                  ),
                                  TextSpan(
                                    text: _formattedTime,
                                    style: const TextStyle(
                                      color: AppColors.darkTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _resendOtp,
                            child: Text(
                              "Resend Code"
                                  .tr, // add this string; falls back to plain text if missing
                              style: context.bodyMedium.copyWith(
                                color: AppColors
                                    .primaryColor, // adjust to your actual accent color
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                      ),

                      const Gap(40),

                      Obx(() {
                        return CustomButton(
                          text: AppStrings.verifyAndContinue.tr,

                          isLoading:
                              controller.isVerifyRegisterOtpLoading.value,

                          onTap: _verifyOtp,
                        );
                      }),
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
