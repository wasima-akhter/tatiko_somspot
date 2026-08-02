import '../../../../share/export/repo_export.dart';
import '../../../../utils/multipart/multipart_body.dart';
import '../model/influencer_complete_profile_request.dart';
import '../model/influencer_info_profile_request.dart';

class InfluencerCompleteProfileRepository {
  final ApiClient _apiClient;

  InfluencerCompleteProfileRepository(this._apiClient);

  Future<Response> completeProfile(InfluencerCompleteProfileRequest request) {
    return _apiClient.uploadMultipart(
      url: ApiUrls.editProfile(),
      method: "PATCH",
      fields: {
        "name": request.name,
        "address": request.address,
        "phoneNumber": request.phoneNumber,
      },
      files: [
        MultipartBody(fieldKey: "profile_image", file: request.profileImage),
      ],
    );
  }

  Future<Response> completeCreatorProfile(
    InfluencerInfoProfileRequest request,
  ) {
    return _apiClient.post(
      url: ApiUrls.influencerProfile(),
      body: {
        "category": request.category,
        "bio": request.bio,
        "followerCount": request.followerCount,
        "socials": request.socials.map((e) => e.toJson()).toList(),
      },
    );
  }
}
