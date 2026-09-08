import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../core/service/datasource/remote/api_exception.dart';
import '../../../../core/service/datasource/remote/api_response.dart';
import '../../../../share/model/pagination_meta_model.dart';
import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../model/category_model.dart';
import '../repository/category_repository.dart';

class CategoryService {
  final CategoryRepository _repository;

  CategoryService(this._repository);

  Future<ApiResponse<PaginatedResult<CategoryModel>>> getCategories({
    int page = 1,
    int limit = 10,
    required CategoryUsage type,
  }) async {
    try {
      final response = await _repository.getAllCategories(
        page: page,
        limit: limit,
        usage: type,
      );

      final responseData = response.data;
      final resultList =
          (responseData['data']?['result'] ?? responseData['result'] ?? [])
              as List;
      final metaJson = responseData['data']?['meta'] ?? responseData['meta'];

      return ApiResponse.success(
        data: PaginatedResult<CategoryModel>(
          data: resultList.map((e) => CategoryModel.fromJson(e)).toList(),
          meta: metaJson != null ? PaginationMeta.fromJson(metaJson) : null,
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("$e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
