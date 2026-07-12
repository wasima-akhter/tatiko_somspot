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

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.influencer:
        return 'Influencer';
      case UserRole.merchandiser:
        return 'Merchandiser';
      case UserRole.customer:
        return 'Customer';
    }
  }

  static UserRole fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'influencer':
        return UserRole.influencer;
      case 'merchandiser':
        return UserRole.merchandiser;
      case 'customer':
        return UserRole.customer;
      default:
        return UserRole.influencer;
    }
  }
}
