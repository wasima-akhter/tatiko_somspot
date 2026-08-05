import '../../../../share/export/repo_export.dart';
import '../request/business-request.dart';

class BusinessRepository {
  final ApiClient _apiClient;

  BusinessRepository(this._apiClient);

  Future<Response> getMyBusinesses({required int page, required int limit}) {
    return _apiClient.get(
      url: ApiUrls.myBusinesses(page: page, limit: limit),
      showResponse: true,
    );
  }

  //
  Future<Response> updateBusiness({required EditBusinessRequest request}) {
    return _apiClient.uploadMultipart(
      url: ApiUrls.updateBusiness(),
      method: "PATCH",
      fields: request.fields(),
      files: request.files(),
    );
  }
}
