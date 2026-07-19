import '../../../../share/export/repo_export.dart';
import '../request/create_offer_request.dart';

class OfferRepository {
  final ApiClient _apiClient;

  OfferRepository(this._apiClient);

  Future<Response> createOffer(CreateOfferRequest request) {
    return _apiClient.post(url: ApiUrls.createOffer(), body: request.toJson());
  }

  Future<Response> getOffersBybusinessId({
    required String businessId,
    int page = 1,
    int limit = 10,
    String status = "active",
  }) async {
    return await _apiClient.get(
      url: ApiUrls.getOffers(),

      queryParams: {
        "business": businessId,

        "page": page,

        "limit": limit,

        "status": status,
      },
    );
  }

  Future<Response> getOffers({
    int page = 1,
    int limit = 10,
    String status = "active",
  }) async {
    return await _apiClient.get(
      showResponse: true,
      url: ApiUrls.getOffers(),

      queryParams: {"page": page, "limit": limit, "status": status},
    );
  }
}
