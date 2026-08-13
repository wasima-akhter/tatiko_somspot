import '../../../../../share/export/repo_export.dart';

class ReviewRepository {
  final ApiClient _apiClient;

  ReviewRepository(this._apiClient);

  /// Get reviews for a specific business.
  /// Public endpoint — no authentication required.
  Future<Response> getBusinessReviews({
    required String businessId,
    int page = 1,
    int limit = 10,
  }) {
    return _apiClient.get(
      showResponse: true,
      skipAuth: true,
      url: ApiUrls.getBusinessReviews(),
      queryParams: {'businessId': businessId, 'page': page, 'limit': limit},
    );
  }

  /// Post a review for a business.
  Future<Response> postReview({
    required String businessId,
    required num rating,
    required String review,
  }) {
    return _apiClient.post(
      showResponse: true,
      url: ApiUrls.postReview(),
      body: {'business': businessId, 'rating': rating, 'review': review},
    );
  }

  /// Get reviews posted by the current customer.
  Future<Response> getMyReviews({int page = 1, int limit = 10}) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.getAllReviews(),
      queryParams: {'page': page, 'limit': limit},
    );
  }
}
