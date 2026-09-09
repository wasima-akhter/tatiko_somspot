import 'package:get/get.dart';

import '../../../utils/app_strings/app_strings.dart';
import '../../export/service_export.dart';
import '../repository/language_repository.dart';
import '../response/language_response.dart';

class LanguageService {
  final LanguageRepository _repository;

  LanguageService(this._repository);

  Future<ApiResponse<LanguageChangeResponse>> changeLanguage({
    required String language,
  }) async {
    try {
      final response = await _repository.changeLanguage(language: language);

      return ApiParser.parse<LanguageChangeResponse>(
        response,
        mapper: (json) => LanguageChangeResponse.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Change Language Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
