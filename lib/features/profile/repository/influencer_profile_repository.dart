import 'package:dio/dio.dart';

import '../../../core/service/datasource/remote/api_client.dart';
import '../../../utils/api_urls/api_urls.dart';
import '../../auth/completed_profile_influencer/model/influencer_info_profile_request.dart';

class InfluencerProfileRepository {
  final ApiClient _apiClient;

  InfluencerProfileRepository(this._apiClient);

  Future<Response> getCreatorProfile() {
    return _apiClient.get(url: ApiUrls.influencerProfile());
  }

  Future<Response> updateCreatorProfile(InfluencerInfoProfileRequest request) {
    return _apiClient.patch(
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
