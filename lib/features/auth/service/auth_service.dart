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
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../repository/auth_repository.dart';

class AuthService {
  AuthService(this._repository);

  final AuthRepository _repository;

  final AppStorage storage = AppStorage.to;

  Future<Response> login(LoginRequest request) async {
    final response = await _repository.login(request);

    if (response.statusCode == 200) {
      // save token
      // save profile
      // save role
    }

    return response;
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
