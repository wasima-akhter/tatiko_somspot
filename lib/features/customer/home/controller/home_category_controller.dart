import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/customer/home/model/category_model.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

class HomeCategoryController extends GetxController {
  static HomeCategoryController get to => Get.find();
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Populates categories list statically and synchronously
  void fetchCategories() {
    final List<CategoryModel> loadedCategories = [
      CategoryModel(
        id: '1',
        name: AppStrings.restaurants.tr,
        icon: Icons.restaurant_menu_outlined,
      ),
      CategoryModel(
        id: '2',
        name: AppStrings.grocery.tr,
        icon: Icons.shopping_basket_outlined,
      ),
      CategoryModel(
        id: '3',
        name: AppStrings.pharmacy.tr,
        icon: Icons.medication_outlined,
      ),
      CategoryModel(
        id: '4',
        name: AppStrings.supermarket.tr,
        icon: Icons.storefront_outlined,
      ),
      CategoryModel(
        id: '5',
        name: AppStrings.cafes.tr,
        icon: Icons.local_cafe_outlined,
      ),
      CategoryModel(
        id: '6',
        name: AppStrings.electronics.tr,
        icon: Icons.devices_other_outlined,
      ),
    ];

    categories.assignAll(loadedCategories);
  }
}
