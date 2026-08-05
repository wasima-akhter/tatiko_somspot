import '../../../../share/export/repo_export.dart';

class InfluencerDashboardRepository {
  final ApiClient _apiClient;

  InfluencerDashboardRepository(this._apiClient);

  Future<Response> influencerDashboard() {
    return _apiClient.get(
      url: ApiUrls.influencerDashboard(),
      showResponse: true,
    );
  }
}
