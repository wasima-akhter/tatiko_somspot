import 'package:dio/dio.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../../core/service/datasource/remote/api_client.dart';
import '../../../../utils/api_urls/api_urls.dart';

class CategoryRepository {
  final ApiClient _apiClient;

  CategoryRepository(this._apiClient);

  Future<Response> getAllCategories() {
    return _apiClient.get(
      url: ApiUrls.getCategories(),
      skipAuth: true,

      queryParams:
          CommonController.to.isCustomer || CommonController.to.isMerchandiser
          ? {"type": "merchant"}
          : {"type": "creator"},
    );
  }
}
