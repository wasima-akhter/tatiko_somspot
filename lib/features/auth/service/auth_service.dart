// class AuthService {

//   // register

//   // login

//   // verify otp --> register

//   // verify otp --> forgot password

//   // resend otp

//   // logout

//   // every step use AppStorage --> save, get , erase properly.

// }

import 'package:dio/dio.dart';

import '../../../core/service/datasource/local/app_storage.dart';
import '../../../core/service/datasource/remote/api_exception.dart';
import '../../../core/service/datasource/remote/api_parser.dart';
import '../../../core/service/datasource/remote/api_response.dart';
import '../../../utils/common_controller/common_controller.dart';
import '../models/login_model.dart';
import '../repository/auth_repository.dart';
import '../requests/login_request.dart';
import '../requests/register_request.dart';

class AuthService {
  AuthService(this._repository);

  final AuthRepository _repository;

  final AppStorage storage = AppStorage.to;

  Future<ApiResponse<LoginModel>> login(LoginRequest request) async {
    try {
      final response = await _repository.login(request);

      final result = ApiParser.parse<LoginModel>(
        response,
        mapper: (json) => LoginModel.fromJson(json),
      );

      if (result.success) {
        final loginData = result.data;

        if (loginData != null) {
          await storage.setAccessToken(loginData.accessToken);

          await storage.setProfile(loginData.user);

          await storage.setRole(
            UserRoleExtension.fromString(loginData.user.userRole),
          );

          await storage.setLoggedIn(true);
        }
      }

      return result;
    } catch (e) {
      if (e is ApiException) {
        return ApiResponse.failure(
          message: e.message,
          statusCode: e.statusCode,
        );
      }

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<Response> register(RegisterRequest request) async {
    final response = await _repository.register(request);

    final body = response.data;

    if (body["success"] == true) {
      final data = body["data"];

      final isActive = data["isActive"] ?? false;

      // Account created but waiting activation
      if (!isActive) {
        await storage.setPendingEmail(request.email);

        await storage.setPendingRole(request.role);
      }

      return response;
    }

    // Account already active
    if (body["data"]?["isActive"] == true) {
      return response;
    }

    return response;
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
    } finally {
      await storage.logout();
    }
  }

  Future<Object?> verifyRegisterOtp(verifyOtpRequest) async {
    return null;
  }
}
