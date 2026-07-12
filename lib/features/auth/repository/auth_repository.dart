import 'package:dio/dio.dart';
import 'package:som_spot/features/auth/requests/resend_otp_request.dart';

import '../../../core/service/datasource/remote/api_client.dart';
import '../../../core/service/datasource/remote/api_exception.dart';
import '../../../core/service/datasource/remote/api_parser.dart';
import '../../../core/service/datasource/remote/api_response.dart';
import '../../../utils/api_urls/api_urls.dart';
import '../models/login_model.dart';
import '../requests/login_request.dart';
import '../requests/register_request.dart';
import '../requests/verify_otp_request.dart';

class AuthRepository {
  AuthRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<Response> register(RegisterRequest request) {
    return _apiClient.post(url: ApiUrls.register(), body: request.toJson());
  }

  Future<ApiResponse<LoginModel>> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        url: ApiUrls.login(),
        body: request.toJson(),
      );

      return ApiParser.parse(response);
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    }
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
