import 'package:flutter/material.dart';
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

  final Rx<UserRole> role = UserRole.customer.obs;

  bool get isMerchandiser => role.value.isMerchandiser;
  bool get isCustomer => role.value.isCustomer;
  bool get isInfluencer => role.value.isInfluencer;

  void setRole(UserRole newRole) => role.value = newRole;
}

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.influencer:
        return 'creator'.toUpperCase();
      case UserRole.merchandiser:
        return 'merchant'.toUpperCase();
      case UserRole.customer:
        return 'User'.toUpperCase();
    }
  }

  static UserRole fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'creator':
        return UserRole.influencer;
      case 'merchant':
        return UserRole.merchandiser;
      case 'user':
        return UserRole.customer;
      default:
        debugPrint(
          "⚠️ [UserRole] Unrecognized role value: '$value' — defaulting to customer",
        );
        return UserRole.customer; // safer default than influencer
    }
  }
}
