import 'dart:developer';

import 'package:get/get.dart';

import '../../../core/router/route_path.dart';
import '../../../core/router/routes.dart';
import '../../../helper/snackbar/api_snackbar.dart';
import '../../../utils/common_controller/common_controller.dart';
import '../completed_profile_customer_merchandiser/view/completed_profile_customer_args.dart';
import '../core/requests/auth_request.dart';
import '../core/service/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _service;

  AuthController(this._service);

  static AuthController get to => Get.find();

  final isLoading = false.obs;

  final errorMessage = ''.obs;

  Future<void> login({required LoginRequest request}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _service.login(request);

      if (!result.success || result.data == null) {
        errorMessage.value = result.message.isNotEmpty
            ? result.message
            : "Login failed";

        Future.delayed(const Duration(milliseconds: 300), () {
          log("something went wrong snack");
          ApiSnackbar.show(errorMessage.value, type: SnackbarType.error);
        });

        return;
      }

      await _handlePostLogin();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isLoading.value = true;
      final selectedRole = CommonController.to.role.value;

      final result = await _service.register(
        RegisterRequest(
          role: selectedRole.value,
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      );

      AppRouter.route.pushNamed(RoutePath.activeOtpScreen, extra: email);

      ApiSnackbar.show(result.message);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyRegisterOtp({
    required String email,
    required String otp,
  }) async {
    try {
      isLoading.value = true;

      final response = await _service.verifyRegisterOtp(
        VerifyOtpRequest(email: email, activationCode: otp),
      );

      if (!response.success || response.data == null) {
        ApiSnackbar.show(response.message, type: SnackbarType.error);
        return;
      }

      await _handlePostLogin();
    } finally {
      isLoading.value = false;
    }
  }

  final RxBool isResending = false.obs;

  Future<void> resendOtp({required String email}) async {
    if (isResending.value) return; // guard against double-taps

    isResending.value = true;

    final request = ResendOtpRequest(
      email: email,
    ); // adjust field name if different
    final result = await _service.resendOtp(request);

    isResending.value = false;

    if (result.success) {
      ApiSnackbar.show(
        result.message.isNotEmpty ? result.message : "Verification code resent",
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
      isLoading.value = true;

      final result = await _service.forgotPassword(
        ForgotPasswordRequest(email: email),
      );

      if (!result.success) {
        ApiSnackbar.show(result.message, type: SnackbarType.error);
        return;
      }

      AppRouter.route.pushNamed(RoutePath.forgetOtpScreen, extra: email);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyForgotPasswordOtp({
    required String email,
    required String code,
  }) async {
    try {
      isLoading.value = true;

      final result = await _service.verifyForgotPasswordOtp(
        VerifyForgotPasswordOtpRequest(email: email, code: code),
      );

      if (!result.success) {
        ApiSnackbar.show(result.message, type: SnackbarType.error);
        return;
      }

      AppRouter.route.pushNamed(RoutePath.resetPasswordScreen, extra: email);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isLoading.value = true;

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
      isLoading.value = false;
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isLoading.value = true;

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
      isLoading.value = false;
    }
  }

  // logout -->

  Future<void> logout() async {
    try {
      isLoading.value = true;

      final result = await _service.logout();

      // if (!result.success) {
      //   ApiSnackbar.show(result.message, type: SnackbarType.error);

      //   return;
      // }

      // ApiSnackbar.show(result.message, type: SnackbarType.success);

      AppRouter.route.pop();
    } finally {
      isLoading.value = false;
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
    CommonController.to.setRole(UserRoleExtension.fromString(user.role));

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
    if (user.role == "MERCHANT" && !user.sections.business.complete) {
      AppRouter.route.goNamed(RoutePath.completeBusinessProfileScreen);
      return;
    }

    // profile completed
    AppRouter.route.goNamed(RoutePath.navigationPages);
  }
}
