import '../../../share/export/service_export.dart';
import '../../auth/completed_profile_influencer/model/influencer_info_profile_request.dart';
import '../models/influencer_profile_model.dart';
import '../repository/influencer_profile_repository.dart';

class InfluencerProfileService {
  final InfluencerProfileRepository _repository;

  InfluencerProfileService(this._repository);

  Future<ApiResponse<InfluencerProfileModel>> getCreatorProfile() async {
    try {
      final response = await _repository.getCreatorProfile();

      final result = ApiParser.parse<InfluencerProfileModel>(
        response,

        mapper: (json) => InfluencerProfileModel.fromJson(json),
      );

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Creator Profile Error: $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<void>> updateCreatorProfile(
    InfluencerInfoProfileRequest request,
  ) async {
    try {
      final response = await _repository.updateCreatorProfile(request);

      return ApiParser.parse<void>(response, mapper: (_) {});
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Update Creator Profile Error: $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}
