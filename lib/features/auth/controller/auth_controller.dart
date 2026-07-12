import 'package:get/get.dart';

import '../../../core/router/route_path.dart';
import '../../../core/router/routes.dart';
import '../models/register_request.dart';
import '../service/auth_service.dart';

class AuthController extends GetxController {
  AuthController(this.authService);

  final AuthService authService;

  static AuthController get to => Get.find();

  final isLoading = false.obs;

  final errorMessage = ''.obs;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isLoading.value = true;

      final response = await authService.register(
        RegisterRequest(
          role: "USER",
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      );

      final body = response.data;

      if (body["success"] == true) {
        AppRouter.route.pushNamed(RoutePath.activeOtpScreen, extra: email);

        return;
      }

      final isActive = body["data"]?["isActive"] ?? false;

      if (isActive) {
        Get.snackbar("Account Exists", "Account active. Please login");

        AppRouter.route.goNamed(RoutePath.loginScreen);
      } else {
        Get.snackbar("Error", body["message"] ?? "Registration failed");
      }
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

      // final response = await authService.verifyRegisterOtp(
      //   VerifyOtpRequest(email: email, otp: otp),
      // );

      // final body = response.data;

      // if (body["success"] == true) {
      //   final role = AppStorage.to.role;

      //   if (role?.isMerchandiser == true) {
      //     AppRouter.route.goNamed(RoutePath.completedProfileScreen);
      //   } else if (role?.isInfluencer == true) {
      //     AppRouter.route.goNamed(RoutePath.completedProfileInfluencerScreen);
      //   } else {
      //     AppRouter.route.goNamed(RoutePath.navigationPages);
      //   }
      // } else {
      //   Get.snackbar("Verification Failed", body["message"] ?? "Invalid OTP");
      // }
    } finally {
      isLoading.value = false;
    }
  }
}
