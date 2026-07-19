import '../../../../share/export/repo_export.dart';

class BusinessRepository {
  final ApiClient _apiClient;

  BusinessRepository(this._apiClient);

  Future<Response> getMyBusinesses({required int page, required int limit}) {
    return _apiClient.get(
      url: ApiUrls.myBusinesses(page: page, limit: limit),
    );
  }
}
