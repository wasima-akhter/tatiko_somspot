import 'package:get/get.dart';

import '../../../share/export/service_export.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../model/feedback_model.dart';
import '../model/rate-app_model.dart';
import '../model/terms_conditions_model.dart';
import '../repository/other_repository.dart';
import '../request/help_support-request.dart';
import '../request/rate_app_request.dart';

class OtherService {
  final OtherRepository _repository;

  OtherService(this._repository);

  Future<ApiResponse<FeedbackModel>> postFeedback(
    FeedbackRequest request,
  ) async {
    try {
      final response = await _repository.postFeedback(request);

      return ApiParser.parse<FeedbackModel>(
        response,
        mapper: (json) => FeedbackModel.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Post Feedback Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<TermsConditionsModel>> getTermsConditions() async {
    try {
      final response = await _repository.getTermsConditions();

      final result = ApiParser.parse<TermsConditionsModel>(
        response,
        mapper: (json) => TermsConditionsModel.fromJson(json),
      );

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Terms Conditions Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<TermsConditionsModel>> getPrivacyPolicy() async {
    try {
      final response = await _repository.getPrivacyPolicy();

      final result = ApiParser.parse<TermsConditionsModel>(
        response,
        mapper: (json) => TermsConditionsModel.fromJson(json),
      );

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Privacy Policy Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<RateAppModel>> rateApp(RateAppRequest request) async {
    try {
      final response = await _repository.rateApp(request);

      final result = ApiParser.parse<RateAppModel>(
        response,
        mapper: (json) => RateAppModel.fromJson(json),
      );

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Rate App Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<TermsConditionsModel>> getAboutUs() async {
    try {
      final response = await _repository.getAboutUs();

      final result = ApiParser.parse<TermsConditionsModel>(
        response,
        mapper: (json) => TermsConditionsModel.fromJson(json),
      );

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get About Us Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
