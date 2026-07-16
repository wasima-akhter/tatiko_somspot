// class AuthService {

//   // register

//   // login

//   // verify otp --> register

//   // verify otp --> forgot password

//   // resend otp

//   // logout

//   // every step use AppStorage --> save, get , erase properly.

// }

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../core/service/datasource/local/app_storage.dart';
import '../../../core/service/datasource/remote/api_exception.dart';
import '../../../core/service/datasource/remote/api_parser.dart';
import '../../../core/service/datasource/remote/api_response.dart';
import '../models/curr_user_response.dart';
import '../models/login_model.dart';
import '../models/register_response.dart';
import '../repository/auth_repository.dart';
import '../requests/auth_request.dart';

class AuthService {
  final AuthRepository _repository;

  AuthService(this._repository);

  AppStorage get storage => AppStorage.to;

  Future<ApiResponse<LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _repository.login(request);

      final result = ApiParser.parse<LoginResponse>(
        response,
        mapper: (json) => LoginResponse.fromJson(json),
      );

      if (!result.success || result.data == null) {
        return ApiResponse.failure(
          message: result.message,
          statusCode: result.statusCode,
        );
      }

      await _saveLoginSession(result.data!);

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Login Error: $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<CurrentUserResponse>> me() async {
    try {
      final response = await _repository.me();

      return ApiParser.parse(
        response,
        mapper: (json) => CurrentUserResponse.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (_) {
      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    final response = await _repository.register(request);

    final result = ApiParser.parse<RegisterResponse>(
      response,
      mapper: (json) => RegisterResponse.fromJson(json),
    );

    if (result.success && result.data?.isActive == false) {
      await storage.setPendingEmail(request.email);

      await storage.setPendingRole(request.role);
    }

    return result.data!;
  }

  Future<void> logout() async {
    try {
      await _repository.logout();
    } finally {
      await storage.logout();
    }
  }

  Future<ApiResponse<LoginResponse>> verifyRegisterOtp(
    VerifyOtpRequest request,
  ) async {
    try {
      final response = await _repository.verifyRegisterOtp(request);

      final result = ApiParser.parse<LoginResponse>(
        response,
        mapper: (json) => LoginResponse.fromJson(json),
      );

      if (!result.success || result.data == null) {
        return ApiResponse.failure(
          message: result.message,
          statusCode: result.statusCode,
        );
      }

      // Save tokens after OTP verification
      await _saveLoginSession(result.data!);

      // OTP completed, remove pending data
      await storage.clearPendingRegister();

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Verify OTP Error: $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<void>> resendOtp(ResendOtpRequest request) async {
    try {
      final response = await _repository.resendOtp(request);

      final result = ApiParser.parse<void>(response);

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Resend OTP Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<void>> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    try {
      final response = await _repository.forgotPassword(request);

      final result = ApiParser.parse<void>(response, mapper: (_) {});

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Forgot Password Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<void>> verifyForgotPasswordOtp(
    VerifyForgotPasswordOtpRequest request,
  ) async {
    try {
      final response = await _repository.verifyForgotPasswordOtp(request);

      final result = ApiParser.parse<void>(response, mapper: (_) {});

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Verify Forgot OTP Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<void>> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await _repository.resetPassword(request);

      final result = ApiParser.parse<void>(response, mapper: (_) {});

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Reset Password Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<void>> changePassword(
    ChangePasswordRequest request,
  ) async {
    try {
      final response = await _repository.changePassword(request);

      final result = ApiParser.parse<void>(response, mapper: (_) {});

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Change Password Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}

Future<void> _saveLoginSession(LoginResponse login) async {
  final storage = AppStorage.to;
  final accessToken = login.accessToken ?? '';
  final refreshToken = login.refreshToken ?? '';

  if (accessToken.isEmpty) {
    return;
  }

  final accessPayload = Jwt.parseJwt(accessToken);

  final refreshPayload = Jwt.parseJwt(refreshToken);

  final userId = accessPayload['userId']?.toString();

  final authId = accessPayload['authId']?.toString();

  final email = accessPayload['email']?.toString();

  final role = accessPayload['role']?.toString();

  debugPrint("🔍 [JWT] raw role claim: $role");
  debugPrint("🔍 [JWT] full payload:  ");

  debugPrint(const JsonEncoder.withIndent('  ').convert(accessPayload));

  await storage.saveSession(
    accessToken: accessToken,
    refreshToken: refreshToken,
    authId: authId,
    userId: userId,
    email: email,
    role: UserRoleExtension.fromString(role),
  );

  await storage.setTokenExpiry(int.parse(accessPayload['exp'].toString()));

  await storage.setRefreshTokenExpiry(
    int.parse(refreshPayload['exp'].toString()),
  );
}
