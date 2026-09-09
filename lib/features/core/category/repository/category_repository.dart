import 'package:dio/dio.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../../core/service/datasource/remote/api_client.dart';
import '../../../../utils/api_urls/api_urls.dart';

class CategoryRepository {
  final ApiClient _apiClient;

  CategoryRepository(this._apiClient);

  Future<Response> getAllCategories({
    int page = 1,
    int limit = 10,
    required CategoryUsage usage,
  }) {
    return _apiClient.get(
      url: ApiUrls.getCategories(),
      skipAuth: true,
      showResponse: true,
      queryParams: {
        "page": page,
        "limit": limit,
        "type": _getCategoryType(usage),
      },
    );
  }

  String _getCategoryType(CategoryUsage usage) {
    print(
      '📂 [CategoryRepository] Resolving category type | '
      'usage: $usage | '
      'isCustomer: ${CommonController.to.isCustomer} | '
      'isMerchandiser: ${CommonController.to.isMerchandiser} | '
      'isInfluencer: ${CommonController.to.isInfluencer}',
    );

    if (CommonController.to.isCustomer) {
      print('📂 [CategoryRepository] User is CUSTOMER → type: merchant');
      return "merchant";
    }

    if (CommonController.to.isMerchandiser) {
      switch (usage) {
        case CategoryUsage.businessProfile:
          print(
            '📂 [CategoryRepository] Merchandiser + businessProfile → type: merchant',
          );
          return "merchant";

        case CategoryUsage.campaign:
          print(
            '📂 [CategoryRepository] Merchandiser + campaign → type: creator',
          );
          return "creator";

        case CategoryUsage.none:
          print('📂 [CategoryRepository] Merchandiser + none → type: merchant');
          return "merchant";
      }
    }

    if (CommonController.to.isInfluencer) {
      print('📂 [CategoryRepository] User is INFLUENCER → type: creator');
      return "creator";
    }

    print(
      '📂 [CategoryRepository] No matching role → type: creator (fallback)',
    );

    return "creator";
  }
}

enum CategoryUsage { businessProfile, campaign, none }
