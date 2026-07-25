import '../../../../share/export/repo_export.dart';

class DashboardMerchantRepository {
  final ApiClient _apiClient;

  DashboardMerchantRepository(this._apiClient);

  Future<Response> merchantDashboard() {
    return _apiClient.get(url: ApiUrls.merchantDashboard(), showResponse: true);
  }
}
