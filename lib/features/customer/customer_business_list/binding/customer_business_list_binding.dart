import 'package:get/get.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../../customer_home/service/customer_home_service.dart';
import '../arg/customer_business_list_arg_model.dart';
import '../controller/customer_business_list_controller.dart';

class CustomerBusinessListBinding extends Bindings {
  final CustomerBusinessListArgModel? categoryInfo;

  CustomerBusinessListBinding({this.categoryInfo});

  @override
  void dependencies() {
    Get.lazyPut<CustomerBusinessListController>(
      () => CustomerBusinessListController(
        sl<CustromerHomeService>(),
        categoryInfo: categoryInfo,
      ),
    );
  }
}
