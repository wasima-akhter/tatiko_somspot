import '../../../../../share/export/repo_export.dart';
import '../request/new_campaign_request.dart';

class MerchantCampaignRepository {
  final ApiClient _apiClient;

  MerchantCampaignRepository(this._apiClient);

  Future<Response> createNewCampaign(CreateCampaignRequest request) {
    return _apiClient.post(
      url: ApiUrls.createMerchantCampaign(),
      body: request.toJson(),
    );
  }

  Future<Response> getCampaigns({
    int page = 1,
    int limit = 10,
    String status = "all",
  }) {
    return _apiClient.get(
      url: ApiUrls.merchantCampaigns(),

      queryParams: {'page': page, 'limit': limit, 'status': status},
    );
  }
}
