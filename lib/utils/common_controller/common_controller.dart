import 'package:get/get.dart';

import '../enum/app_enum.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();

  final List<String> roleTitles = const ["Customer", "Merchant", "Influencer"];

  final List<UserRole> roles = const [
    UserRole.customer,
    UserRole.merchandiser,
    UserRole.influencer,
  ];

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
        return 'Influencer'.toUpperCase();
      case UserRole.merchandiser:
        return 'Merchandiser'.toUpperCase();
      case UserRole.customer:
        return 'User'.toUpperCase();
    }
  }

  static UserRole fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'influencer':
        return UserRole.influencer;
      case 'merchandiser':
        return UserRole.merchandiser;
      case 'user':
        return UserRole.customer;
      default:
        return UserRole.influencer;
    }
  }
}
