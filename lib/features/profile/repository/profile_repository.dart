import 'package:dio/dio.dart';

import '../../../core/service/datasource/remote/api_client.dart';
import '../../../utils/api_urls/api_urls.dart';
import '../request/edit_profile_request.dart';

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository(this._apiClient);

  Future<Response> editProfile(EditProfileRequest request) {
    return _apiClient.uploadMultipart(
      url: ApiUrls.editProfile(),
      method: "PATCH",
      fields: request.fields(),
      files: request.files(),
    );
  }

  Future<Response> getProfile() {
    return _apiClient.get(url: ApiUrls.userProfile());
  }
}
