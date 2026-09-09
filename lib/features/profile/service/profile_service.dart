import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/service/datasource/remote/api_exception.dart';
import '../../../core/service/datasource/remote/api_parser.dart';
import '../../../core/service/datasource/remote/api_response.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../models/edit_profile_response.dart';
import '../models/get_profile_model.dart';
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
      print("Edit Profile Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  /*

import 'package:flutter/foundation.dart';

import '../../../../core/service/datasource/remote/api_exception.dart';
import '../../../../core/service/datasource/remote/api_parser.dart';
import '../../../../core/service/datasource/remote/api_response.dart';
import '../repository/complete_business_profile_repository.dart';
import 'complete_business_profile_request.dart';
import 'complete_business_profile_response.dart';

class CompleteBusinessProfileService {
  final CompleteBusinessProfileRepository _repository;

  CompleteBusinessProfileService(this._repository);

  Future<ApiResponse<CompleteBusinessProfileResponse>> createBusiness(
    CompleteBusinessProfileRequest request,
  ) async {
    try {
      final response = await _repository.createBusiness(request);

      return ApiParser.parse<CompleteBusinessProfileResponse>(
        response,
        mapper: (json) => CompleteBusinessProfileResponse.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("$e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}



*/
  Future<ApiResponse<GetProfileModel>> getProfile() async {
    try {
      final response = await _repository.getProfile();

      print("response before parsing: ${response.data}");

      final result = ApiParser.parse<GetProfileModel>(
        response,
        mapper: (json) => GetProfileModel.fromJson(json),
      );

      print("result after parsing: ${result.data?.email}");

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Get Profile Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
