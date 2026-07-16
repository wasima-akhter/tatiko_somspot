import 'package:get/get.dart';

import '../../../core/di/repo_service_injection.dart';
import 'controller/category_controller.dart';
import 'service/category_service.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(sl<CategoryService>()),
      fenix: true,
    );
  }
}
