import 'package:dio/dio.dart';

import '../../../../core/service/datasource/remote/api_client.dart';
import '../../../../utils/api_urls/api_urls.dart';
import '../requests/auth_request.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<Response> register(RegisterRequest request) {
    return _apiClient.post(
      url: ApiUrls.register(),
      body: request.toJson(),
      skipAuth: true,
    );
  }

  Future<Response> login(LoginRequest request) {
    return _apiClient.post(
      url: ApiUrls.login(),
      body: request.toJson(),
      skipAuth: true,
    );
  }

  Future<Response> me() {
    return _apiClient.get(url: ApiUrls.me());
  }

  Future<Response> verifyRegisterOtp(VerifyOtpRequest request) {
    return _apiClient.post(
      url: ApiUrls.activateAccount(),
      body: request.toJson(),
      skipAuth: true,
    );
  }

  Future<Response> resendOtp(ResendOtpRequest request) {
    return _apiClient.post(
      url: ApiUrls.activationCodeResend(),
      body: request.toJson(),
      skipAuth: true,
    );
  }

  Future<Response> forgotPassword(ForgotPasswordRequest request) {
    return _apiClient.post(
      url: ApiUrls.forgotPassword(),
      body: request.toJson(),
      skipAuth: true,
    );
  }

  Future<Response> verifyForgotPasswordOtp(
    VerifyForgotPasswordOtpRequest request,
  ) {
    return _apiClient.post(
      url: ApiUrls.verifyForgetPasswordOtp(),
      body: request.toJson(),
      skipAuth: true,
    );
  }

  Future<Response> resetPassword(ResetPasswordRequest request) {
    return _apiClient.post(
      url: ApiUrls.resetPassword(),
      body: request.toJson(),
      skipAuth: true,
    );
  }

  Future<Response> changePassword(ChangePasswordRequest request) {
    return _apiClient.patch(
      url: ApiUrls.changePassword(),
      body: request.toJson(),
    );
  }

  Future<Response> logout() {
    return _apiClient.post(url: ApiUrls.logout(), body: {});
  }
}
