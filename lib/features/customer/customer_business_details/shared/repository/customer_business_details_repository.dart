import '../../../../../share/export/repo_export.dart';

class CustomerBusinessDetailsRepository {
  final ApiClient _apiClient;

  CustomerBusinessDetailsRepository(this._apiClient);

  Future<Response> getBusinessDetails(String businessId) {
    return _apiClient.get(
      url: ApiUrls.getCustomerBusinessDetails(),
      queryParams: {'businessId': businessId},
    );
  }

  //
  // ============================================================
  // Get Offers
  // ============================================================

  Future<Response> getOffers({
    int page = 1,
    int limit = 10,
    String status = "",
  }) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.getCustomerOffers(),
      queryParams: status.isEmpty
          ? {'page': page, 'limit': limit}
          : {'page': page, 'limit': limit, 'status': status},
    );
  }
}
