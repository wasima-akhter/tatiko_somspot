import 'package:get/get.dart';
import 'package:som_spot/features/core/category/repository/category_repository.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../controller/category_controller.dart';
import '../service/category_service.dart';

class CategoryBinding extends Bindings {
  final CategoryUsage categoryUsage;
  final String tag;

  CategoryBinding({required this.categoryUsage, required this.tag});

  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(
        sl<CategoryService>(),
        categoryUsageType: categoryUsage,
      ),
      tag: tag,
      fenix: true,
    );
  }
}
