import 'package:get/get.dart';

import '../enum/app_enum.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();

  final Rx<UserRole> role = UserRole.influencer.obs;

  bool get isMerchandiser => role.value.isMerchandiser;
  bool get isCustomer => role.value.isCustomer;
  bool get isInfluencer => role.value.isInfluencer;

  void setRole(UserRole newRole) => role.value = newRole;
}
