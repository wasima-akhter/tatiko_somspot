import '../../../../../share/export/repo_export.dart';

class CustomerSearchRepository {
  final ApiClient _apiClient;

  CustomerSearchRepository(this._apiClient);

  /// Search business or deal
  Future<Response> search({required String term}) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.customerSearch(),
      queryParams: {'term': term},
    );
  }

  /// Get recent search history
  Future<Response> getRecentSearches() {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.customerRecentSearches(),
    );
  }

  /// Clear recent search history
  Future<Response> clearRecentSearches() {
    return _apiClient.delete(
      showResponse: true,
      url: ApiUrls.customerClearRecentSearches(),
    );
  }

  /// Get trending search keywords
  Future<Response> getTrendingSearches() {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.customerTrendingSearches(),
      skipAuth: true,
    );
  }
}
