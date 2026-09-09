import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';

import '../../../../../core/service/datasource/local/app_storage.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../../../../../utils/common_controller/common_controller.dart';
import '../../../../../utils/enum/app_enum.dart';
import '../../splash/app_flow_router.dart';

class ChooseRoleController extends GetxController {
  static ChooseRoleController get to => Get.find();

  final List<String> roleTitles = CommonController.to.roleTitles;

  /// Local/pending selection — kept separate from CommonController.role
  /// so we only commit the global role once the user hits Continue.
  final Rx<UserRole?> selectedRole = Rx<UserRole?>(null);

  bool get canContinue => selectedRole.value != null;

  List<String> get roleDescriptions => [
    AppStrings.shopRoleDescription,
    AppStrings.merchandiserRoleDescription,
    AppStrings.influencerRoleDescription,
  ];
  List<IconData> get roleIcons => [
    Icons.local_offer_outlined, // Customer — claims offers
    Icons.business_center_outlined, // Merchant — business/offers
    Icons.campaign_outlined, // Influencer — promotes/content
  ];

  @override
  void onInit() {
    super.onInit();
    // Pre-select whatever role is already active globally, if any.
    selectedRole.value = CommonController.to.role.value;
  }

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  void confirmAndContinue() {
    final role = selectedRole.value;

    if (role == null) {
      print("ROLE IS NULL");
      return;
    }

    print("Selected role: ${role.name}");

    if (!CommonController.to.setRole(role)) {
      return;
    }

    AppStorage.to.setSelectedRole(selectedRole.value!);

    AppFlowRouter.afterRoleSelected();

    AppRouter.route.goNamed(RoutePath.onboardingScreen);
  }
}
