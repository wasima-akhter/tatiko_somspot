import 'package:dio/dio.dart';
import 'package:som_spot/features/auth/models/resend_otp_request.dart';

import '../../../core/service/datasource/remote/api_client.dart';
import '../../../utils/api_urls/api_urls.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/verify_otp_request.dart';

class AuthRepository {
  AuthRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<Response> register(RegisterRequest request) {
    return _apiClient.post(url: ApiUrls.register(), body: request.toJson());
  }

  Future<Response> login(LoginRequest request) {
    return _apiClient.post(url: ApiUrls.login(), body: request.toJson());
  }

  Future<Response> verifyRegisterOtp(VerifyOtpRequest request) {
    return _apiClient.post(
      url: ApiUrls.verifyPhoneOtp(),
      body: request.toJson(),
    );
  }

  Future<Response> verifyForgotPasswordOtp(VerifyOtpRequest request) {
    return _apiClient.post(
      url: ApiUrls.verifyForgetPasswordOtp(),
      body: request.toJson(),
    );
  }

  Future<Response> resendOtp(ResendOtpRequest request) {
    return _apiClient.post(
      url: ApiUrls.activationCodeResend(),
      body: request.toJson(),
    );
  }

  Future<Response> logout() {
    return _apiClient.post(url: ApiUrls.logout(), body: {});
  }
}
