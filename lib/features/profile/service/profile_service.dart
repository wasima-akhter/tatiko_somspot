import 'package:flutter/foundation.dart';

import '../../../core/service/datasource/remote/api_exception.dart';
import '../../../core/service/datasource/remote/api_parser.dart';
import '../../../core/service/datasource/remote/api_response.dart';
import '../models/edit_profile_response.dart';
import '../models/profile_response.dart';
import '../repository/profile_repository.dart';
import '../request/edit_profile_request.dart';

class ProfileService {
  final ProfileRepository _repository;

  ProfileService(this._repository);

  Future<ApiResponse<EditProfileModel>> editProfile(
    EditProfileRequest request,
  ) async {
    try {
      final response = await _repository.editProfile(request);

      final result = ApiParser.parse<EditProfileModel>(
        response,
        mapper: (json) => EditProfileModel.fromJson(json),
      );

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Edit Profile Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<ProfileModel>> getProfile() async {
    try {
      final response = await _repository.getProfile();

      debugPrint("response before parsing: ${response.data}");

      final result = ApiParser.parse<ProfileModel>(
        response,
        mapper: (json) => ProfileModel.fromJson(json),
      );

      debugPrint("result after parsing: ${result.data?.email}");

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Profile Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}
