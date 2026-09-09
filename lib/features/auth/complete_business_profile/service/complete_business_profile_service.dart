import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/service/datasource/remote/api_exception.dart';
import '../../../../core/service/datasource/remote/api_parser.dart';
import '../../../../core/service/datasource/remote/api_response.dart';
import '../../../../utils/app_strings/app_strings.dart';
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
