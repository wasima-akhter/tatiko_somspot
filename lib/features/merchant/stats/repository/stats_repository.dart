import '../../../../share/export/repo_export.dart';

class StatsRepository {
  final ApiClient _apiClient;

  StatsRepository(this._apiClient);

  Future<Response> merchantAnalytics() {
    return _apiClient.get(url: ApiUrls.merchantAnalytics(), showResponse: true);
  }
}
