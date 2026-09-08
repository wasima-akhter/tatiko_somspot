import 'package:get/get.dart';

import '../controller/category_controller.dart';
import '../repository/category_repository.dart';
import 'category_binding.dart';

class CategoryBindings {
  static CategoryBinding get customerBinding => CategoryBinding(
    categoryUsage: CategoryUsage.none,
    tag: 'customerCategory',
  );

  static CategoryBinding get influencerBinding => CategoryBinding(
    categoryUsage: CategoryUsage.none,
    tag: 'influencerCategory',
  );

  static CategoryBinding get businessProfileBinding => CategoryBinding(
    categoryUsage: CategoryUsage.businessProfile,
    tag: 'businessProfileCategory',
  );

  static CategoryBinding get campaignBinding => CategoryBinding(
    categoryUsage: CategoryUsage.campaign,
    tag: 'campaignCategory',
  );

  // controllers

  static CategoryController get customerController =>
      Get.find<CategoryController>(tag: 'customerCategory');

  static CategoryController get influencerController =>
      Get.find<CategoryController>(tag: 'influencerCategory');

  static CategoryController get businessProfileController =>
      Get.find<CategoryController>(tag: 'businessProfileCategory');

  static CategoryController get campaignController =>
      Get.find<CategoryController>(tag: 'campaignCategory');
}
