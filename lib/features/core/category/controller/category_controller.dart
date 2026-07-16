import 'package:get/get.dart';

import '../../../../helper/snackbar/api_snackbar.dart';
import '../model/category_model.dart';
import '../service/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService _service;

  CategoryController(this._service);

  static CategoryController get to => Get.find();

  final categories = <CategoryModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final response = await _service.getCategories();

      if (response.success && response.data != null) {
        categories.value = response.data!;
      } else {
        ApiSnackbar.show(response.message, type: SnackbarType.error);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
