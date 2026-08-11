import 'package:get/get.dart';
import 'package:som_spot/features/customer/search/service/customer_search_service.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchScreenController>(
      () => SearchScreenController(sl<CustomerSearchService>()),
    );
  }
}
