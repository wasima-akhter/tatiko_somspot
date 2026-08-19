import '../../export/repo_export.dart';

class LanguageRepository {
  final ApiClient _apiClient;

  LanguageRepository(this._apiClient);

  Future<Response> changeLanguage({required String language}) {
    return _apiClient.patch(
      url: ApiUrls.changeLanguage(),
      body: {'language': language},
    );
  }
}
