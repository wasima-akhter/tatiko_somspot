import 'package:dio/dio.dart';

import '../../../../core/service/datasource/remote/api_client.dart';
import '../../../../utils/api_urls/api_urls.dart';
import '../../../../utils/multipart/multipart_body.dart';
import '../service/complete_profile_request.dart';

class CompleteProfileRepository {
  final ApiClient _apiClient;

  CompleteProfileRepository(this._apiClient);
  Future<Response> completeProfile(CompleteProfileRequest request) {
    return _apiClient.uploadMultipart(
      url: ApiUrls.editProfile(),
      method: "PATCH",
      fields: {"name": request.name, "phoneNumber": request.phoneNumber},
      files: [
        MultipartBody(fieldKey: "profile_image", file: request.profileImage),
      ],
    );
  }
}
