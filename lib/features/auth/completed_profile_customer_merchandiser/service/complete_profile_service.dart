import 'package:flutter/material.dart';
import 'package:som_spot/features/auth/completed_profile_customer_merchandiser/repository/complete_profile_repository.dart';

import '../../../../core/service/datasource/remote/api_exception.dart';
import '../../../../core/service/datasource/remote/api_parser.dart';
import '../../../../core/service/datasource/remote/api_response.dart';
import 'complete_profile_request.dart';
import 'complete_profile_response.dart';

class CompleteProfileService {
  final CompleteProfileRepository _repository;

  CompleteProfileService(this._repository);

  Future<ApiResponse<CompleteProfileResponse>> completeProfile(
    CompleteProfileRequest request,
  ) async {
    try {
      final response = await _repository.completeProfile(request);

      return ApiParser.parse<CompleteProfileResponse>(
        response,
        mapper: (json) => CompleteProfileResponse.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("$e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}
