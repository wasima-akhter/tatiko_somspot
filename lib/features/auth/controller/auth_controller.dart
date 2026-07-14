import 'package:get/get.dart';

import '../../../core/router/route_path.dart';
import '../../../core/router/routes.dart';
import '../../../core/service/datasource/local/app_storage.dart';
import '../../../helper/snackbar/api_snackbar.dart';
import '../../../utils/common_controller/common_controller.dart';
import '../requests/auth_request.dart';
import '../service/auth_service.dart';

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

      print("LOGIN SERVICE START");

      final result = await _service.login(request);

      print("LOGIN SERVICE RESPONSE: ${result.success}");
      print("LOGIN SERVICE MESSAGE: ${result.message}");
      print("LOGIN SERVICE DATA: ${result.data}");

      if (!result.success || result.data == null) {
        errorMessage.value = result.message.isNotEmpty
            ? result.message
            : "Login failed";

        Future.delayed(const Duration(milliseconds: 300), () {
          ApiSnackbar.show(errorMessage.value, type: SnackbarType.error);
        });

        return;
      }

      AppRouter.route.goNamed(RoutePath.navigationPages);
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

      if (result.success) {
        AppRouter.route.pushNamed(RoutePath.activeOtpScreen, extra: email);

        return;
      }

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

      final role = AppStorage.to.role;

      if (role?.isMerchandiser == true) {
        AppRouter.route.goNamed(RoutePath.completedProfileScreen);
      } else if (role?.isInfluencer == true) {
        AppRouter.route.goNamed(RoutePath.completedProfileInfluencerScreen);
      } else {
        AppRouter.route.goNamed(RoutePath.navigationPages);
      }
    } finally {
      isLoading.value = false;
    }
  }

  ///
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
}
