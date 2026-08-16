import 'package:get/get.dart';

import '../../../../share/export/service_export.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../model/influencer_complete_profile_request.dart';
import '../model/influencer_info_profile_request.dart';
import '../repository/influencer_complete_profile_repository.dart';

class InfluencerCompleteProfileService {
  final InfluencerCompleteProfileRepository _repository;

  InfluencerCompleteProfileService(this._repository);

  Future<ApiResponse<void>> completeProfile(
    InfluencerCompleteProfileRequest request,
  ) async {
    try {
      final response = await _repository.completeProfile(request);

      return ApiParser.parse<void>(response, mapper: (_) {});
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("$e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<void>> completeCreatorProfile(
    InfluencerInfoProfileRequest request,
  ) async {
    try {
      final response = await _repository.completeCreatorProfile(request);

      return ApiParser.parse<void>(response, mapper: (_) {});
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("$e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
