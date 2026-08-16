import 'dart:io';

import 'package:get/get.dart';
import 'package:som_spot/share/export/service_export.dart';

import '../../../../utils/app_strings/app_strings.dart';
import '../repository/manage_business_repository.dart';

class ManageBusinessService {
  final ManageBusinessRepository _repository;

  ManageBusinessService(this._repository);

  Future<ApiResponse<dynamic>> updateBusiness({
    required Map<String, dynamic> data,

    File? logo,

    File? coverImage,

    List<File>? gallery,
  }) async {
    try {
      final response = await _repository.updateBusiness(
        data: data,
        logo: logo,
        coverImage: coverImage,
        gallery: gallery,
      );

      return ApiParser.parse(response, mapper: (json) => json);
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e) {
      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
