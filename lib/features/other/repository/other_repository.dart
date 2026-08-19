import '../../../share/export/repo_export.dart';
import '../request/help_support-request.dart';
import '../request/rate_app_request.dart';

class OtherRepository {
  final ApiClient _apiClient;

  OtherRepository(this._apiClient);

  Future<Response> postFeedback(FeedbackRequest request) {
    return _apiClient.post(url: ApiUrls.postFeedback(), body: request.toJson());
  }

  Future<Response> getTermsConditions() {
    return _apiClient.get(
      url: ApiUrls.getTermsConditions(),
      showResponse: true,
    );
  }

  Future<Response> getPrivacyPolicy() {
    return _apiClient.get(url: ApiUrls.getPrivacyPolicy(), showResponse: true);
  }

  Future<Response> rateApp(RateAppRequest request) {
    return _apiClient.post(url: ApiUrls.rateApp(), body: request.toJson());
  }

  Future<Response> getAboutUs() {
    return _apiClient.get(url: ApiUrls.getAboutUs());
  }

  // ---------------------------------------------------------------------------
  // FAQ
  // ---------------------------------------------------------------------------

  Future<Response> getFaq({int page = 1, int limit = 10}) {
    return _apiClient.get(
      url: ApiUrls.getFaq(),
      showResponse: true,
      queryParams: {'page': page, 'limit': limit},
    );
  }
}
