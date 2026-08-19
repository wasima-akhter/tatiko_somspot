import '../../../../share/export/repo_export.dart';

class HomeContentRepository {
  final ApiClient _apiClient;

  HomeContentRepository(this._apiClient);
  Future<Response> getCreatorContent({int page = 1, int limit = 10}) {
    return _apiClient.get(
      showResponse: true,
      skipAuth: true,
      url: ApiUrls.getCreatorContent(),
      queryParams: {'page': page, 'limit': limit},
    );
  }

  //
  Future<Response> getNearbyBusinesses({
    required double lat,
    required double lng,
    int page = 1,
    int limit = 10,
    double radiusKm = 10,
    String? category,
  }) async {
    return await _apiClient.get(
      showResponse: true,
      url: ApiUrls.getNearbyBusinesses(),
      queryParams: {
        'lat': lat,
        'lng': lng,
        'radiusKm': radiusKm,
        'page': page,
        'limit': limit,
        if (category != null && category.isNotEmpty) 'category': category,
      },
    );
  }

  Future<Response> getTopDeals({int page = 1, int limit = 10}) async {
    return await _apiClient.get(
      showResponse: true,
      url: ApiUrls.getTopDeals(),
      queryParams: {'page': page, 'limit': limit},
    );
  }
}
