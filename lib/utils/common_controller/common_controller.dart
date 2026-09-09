import 'package:get/get.dart';
import 'package:som_spot/helper/snackbar/api_snackbar.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../enum/app_enum.dart';

class CommonController extends GetxController {
  static CommonController get to => Get.find();

  // final List<String> roleTitles = const ["Customer", "Merchant", "Influencer"];
  final List<String> roleTitles = [
    AppStrings.customer,
    AppStrings.merchant,
    AppStrings.influencer,
  ];

  final List<UserRole> roles = const [
    UserRole.customer,
    UserRole.merchandiser,
    UserRole.influencer,
  ];

  final Rx<UserRole> role = UserRole.influencer.obs;

  bool get isMerchandiser => role.value.isMerchandiser;
  bool get isCustomer => role.value.isCustomer;
  bool get isInfluencer => role.value.isInfluencer;

  bool setRole(UserRole? newRole) {
    if (newRole == null) {
      ApiSnackbar.show(
        title: AppStrings.accountRoleError.tr,
        AppStrings.accountRoleErrorDesc.tr,

        type: SnackbarType.error,
      );

      return false;
    }

    role.value = newRole;
    return true;
  }
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

  static UserRole? fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'creator':
        return UserRole.influencer;
      case 'merchant':
        return UserRole.merchandiser;
      case 'user':
        return UserRole.customer;
      default:
        print("⚠️ [UserRole] Unrecognized role value: '$value'");
        return null;
    }
  }

  //
}
