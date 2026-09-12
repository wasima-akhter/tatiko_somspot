import 'package:get/get.dart';

import '../../../core/router/route_path.dart';
import '../../../core/router/routes.dart';
import '../../../helper/snackbar/api_snackbar.dart';
import '../../../helper/toast/toast_helper.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../../../utils/common_controller/common_controller.dart';
import '../completed_profile_customer_merchandiser/completed_profile_customer_args.dart';
import '../core/requests/auth_request.dart';
import '../core/service/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _service;

  AuthController(this._service);

  static AuthController get to => Get.find();

  final errorMessage = ''.obs;

  final isLoginLoading = false.obs;
  final isRegisterLoading = false.obs;
  final isVerifyRegisterOtpLoading = false.obs;
  final isResendingOtp = false.obs;
  final isForgotPasswordLoading = false.obs;
  final isVerifyForgotPasswordOtpLoading = false.obs;
  final isResetPasswordLoading = false.obs;
  final isChangePasswordLoading = false.obs;
  final isLogoutLoading = false.obs;

  //

  Future<void> login({required LoginRequest request}) async {
    try {
      isLoginLoading.value = true;
      errorMessage.value = '';

      final result = await _service.login(request);

      // Inactive account
      if (result.statusCode == 400 &&
          result.message.toLowerCase().contains('activate your account')) {
        final resendResult = await _service.resendOtp(
          ResendOtpRequest(email: request.email),
        );

        if (!resendResult.success) {
          ApiSnackbar.show(resendResult.message, type: SnackbarType.error);
          return;
        }

        AppRouter.route.goNamed(
          RoutePath.activeOtpScreen,
          extra: request.email,
        );

        return;
      }

      // Other login errors
      if (!result.success || result.data == null) {
        errorMessage.value = result.message.isNotEmpty
            ? result.message
            : AppStrings.loginFailed.tr;

        ApiSnackbar.show(errorMessage.value, type: SnackbarType.error);

        return;
      }

      // Successful login
      await _handlePostLogin();
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    try {
      isRegisterLoading.value = true;

      final result = await _service.register(
        RegisterRequest(
          role: role,
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      );

      AppRouter.route.pushNamed(RoutePath.activeOtpScreen, extra: email);

      ApiSnackbar.show(AppStrings.registrationCompletedSuccessfully.tr);
    } finally {
      isRegisterLoading.value = false;
    }
  }

  Future<void> verifyRegisterOtp({
    required String email,
    required String otp,
  }) async {
    try {
      isVerifyRegisterOtpLoading.value = true;

      final response = await _service.verifyRegisterOtp(
        VerifyOtpRequest(email: email, activationCode: otp),
      );

      if (!response.success || response.data == null) {
        ApiSnackbar.show(response.message, type: SnackbarType.error);
        return;
      }

      await _handlePostLogin();
    } finally {
      isVerifyRegisterOtpLoading.value = false;
    }
  }

  Future<void> resendOtp({required String email}) async {
    if (isResendingOtp.value) return; // guard against double-taps

    isResendingOtp.value = true;

    final request = ResendOtpRequest(
      email: email,
    ); // adjust field name if different
    final result = await _service.resendOtp(request);

    isResendingOtp.value = false;

    if (result.success) {
      ApiSnackbar.show(
        result.message.isNotEmpty
            ? result.message
            : AppStrings.verificationCodeResent.tr,
        type: SnackbarType.success,
      );
    } else {
      ApiSnackbar.show(result.message, type: SnackbarType.error);
    }
  }

  ///
  ///
  Future<void> forgotPassword({required String email}) async {
    try {
      isForgotPasswordLoading.value = true;

      final result = await _service.forgotPassword(
        ForgotPasswordRequest(email: email),
      );

      if (!result.success) {
        ApiSnackbar.show(result.message, type: SnackbarType.error);
        return;
      }

      AppRouter.route.pushNamed(RoutePath.forgetOtpScreen, extra: email);
    } finally {
      isForgotPasswordLoading.value = false;
    }
  }

  Future<void> verifyForgotPasswordOtp({
    required String email,
    required String code,
  }) async {
    try {
      isVerifyForgotPasswordOtpLoading.value = true;

      final result = await _service.verifyForgotPasswordOtp(
        VerifyForgotPasswordOtpRequest(email: email, code: code),
      );

      if (!result.success) {
        ApiSnackbar.show(result.message, type: SnackbarType.error);
        return;
      }

      AppRouter.route.pushNamed(RoutePath.resetPasswordScreen, extra: email);
    } finally {
      isVerifyForgotPasswordOtpLoading.value = false;
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isResetPasswordLoading.value = true;

      final result = await _service.resetPassword(
        ResetPasswordRequest(
          email: email,
          newPassword: password,
          confirmPassword: confirmPassword,
        ),
      );

      if (!result.success) {
        ApiSnackbar.show(result.message, type: SnackbarType.error);

        return;
      }

      ApiSnackbar.show(result.message, type: SnackbarType.success);

      AppRouter.route.goNamed(RoutePath.loginScreen);
    } finally {
      isResetPasswordLoading.value = false;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isChangePasswordLoading.value = true;

      final result = await _service.changePassword(
        ChangePasswordRequest(
          oldPassword: oldPassword,
          newPassword: newPassword,
          confirmPassword: confirmPassword,
        ),
      );

      if (!result.success) {
        ApiSnackbar.show(result.message, type: SnackbarType.error);

        return;
      }

      ApiSnackbar.show(result.message, type: SnackbarType.success);

      AppRouter.route.pop();
    } finally {
      isChangePasswordLoading.value = false;
    }
  }

  // logout -->

  Future<void> logout() async {
    try {
      isLogoutLoading.value = true;

      final result = await _service.logout();

      // if (!result.success) {
      //   ApiSnackbar.show(result.message, type: SnackbarType.error);

      //   return;
      // }

      AppToast.success(message: AppStrings.successfullyLoggedOut.tr);
      AppRouter.route.goNamed(RoutePath.loginScreen);
    } finally {
      isLogoutLoading.value = false;
    }
  }

  //
  //
  Future<void> _handlePostLogin() async {
    final me = await _service.me();

    if (!me.success || me.data == null) {
      ApiSnackbar.show(me.message);
      return;
    }

    final user = me.data!;

    //  // Save role globally
    // CommonController.to.setRole(UserRoleExtension.fromString(user.role));
    if (!CommonController.to.setRole(UserRoleExtension.fromString(user.role))) {
      return;
    }

    // inactive account
    if (!user.isActive) {
      final resend = await _service.resendOtp(
        ResendOtpRequest(email: user.email),
      );

      if (!resend.success) {
        ApiSnackbar.show(resend.message);
        return;
      }

      AppRouter.route.goNamed(RoutePath.activeOtpScreen, extra: user.email);

      return;
    }

    // Personal profile not completed
    if (!user.isProfileComplete) {
      switch (user.role) {
        case "MERCHANT":
          AppRouter.route.goNamed(
            RoutePath.completedProfileCustomerScreen,
            extra: CompletedProfileCustomerArgs(
              email: user.email,
              role: user.role,
            ),
          );
          return;

        case "CREATOR":
          if (user.sections.creator?.complete == false) {
            AppRouter.route.goNamed(RoutePath.influencerInfoComplete);
            // AppRouter.route.goNamed(RoutePath.navigationPages);
            return;
          }

          AppRouter.route.goNamed(RoutePath.completedProfileInfluencerScreen);
          return;

        case "USER":
          AppRouter.route.goNamed(
            RoutePath.completedProfileCustomerScreen,
            extra: CompletedProfileCustomerArgs(
              email: user.email,
              role: user.role,
            ),
          );
          return;

        default:
          ApiSnackbar.show(
            "Unknown role ${user.role}",
            type: SnackbarType.error,
          );
          return;
      }
    }

    // Personal profile completed.
    // Merchant may still need to complete business profile.
    // if (user.role == "MERCHANT" && user.missing.contains("business.business")) {
    //   AppRouter.route.goNamed(RoutePath.completeBusinessProfileScreen);
    //   return;
    // }

    // Business profile incomplete
    if (user.role == "MERCHANT" && user.sections.business?.complete == false) {
      AppRouter.route.goNamed(RoutePath.completeBusinessProfileScreen);
      return;
    }

    // profile completed
    AppRouter.route.goNamed(RoutePath.navigationPages);
  }
}
