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
    return _apiClient.get(url: ApiUrls.getTermsConditions());
  }

  Future<Response> getPrivacyPolicy() {
    return _apiClient.get(url: ApiUrls.getPrivacyPolicy());
  }

  Future<Response> rateApp(RateAppRequest request) {
    return _apiClient.post(url: ApiUrls.rateApp(), body: request.toJson());
  }

  Future<Response> getAboutUs() {
    return _apiClient.get(url: ApiUrls.getAboutUs());
  }
}
