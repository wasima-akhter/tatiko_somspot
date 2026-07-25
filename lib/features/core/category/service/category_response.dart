import '../../../customer/home/model/category_model.dart';

class CategoryResponse {
  final List<CategoryModel> result;

  CategoryResponse({required this.result});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      result: (json["result"] as List? ?? [])
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }
}
