import 'package:flutter/foundation.dart';

import '../../../../core/service/datasource/remote/api_exception.dart';
import '../../../../core/service/datasource/remote/api_parser.dart';
import '../../../../core/service/datasource/remote/api_response.dart';
import '../model/category_model.dart';
import '../repository/category_repository.dart';

class CategoryService {
  final CategoryRepository _repository;

  CategoryService(this._repository);

  Future<ApiResponse<List<CategoryModel>>> getCategories() async {
    try {
      final response = await _repository.getAllCategories();

      return ApiParser.parse<List<CategoryModel>>(
        response,

        mapper: (json) {
          final result = json["result"] as List? ?? [];

          return result.map((e) => CategoryModel.fromJson(e)).toList();
        },
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
