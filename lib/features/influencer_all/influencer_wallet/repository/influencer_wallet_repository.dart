import '../../../../share/export/repo_export.dart';

class InfluencerWalletRepository {
  final ApiClient _apiClient;

  InfluencerWalletRepository(this._apiClient);

  Future<Response> walletAnalytics({required String period}) {
    return _apiClient.get(
      url: ApiUrls.creatorWalletAnalytics(),
      showResponse: true,
      queryParams: {"period": period},
    );
  }
}
