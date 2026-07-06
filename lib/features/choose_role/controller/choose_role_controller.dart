import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';

import '../../../utils/common_controller/common_controller.dart';
import '../../../utils/enum/app_enum.dart';

class ChooseRoleController extends GetxController {
  static ChooseRoleController get to => Get.find();

  final List<UserRole> roles = const [
    UserRole.customer,
    UserRole.merchandiser,
    UserRole.influencer,
  ];

  final List<String> roleTitles = const ["Customer", "Merchant", "Influencer"];

  /// Local/pending selection — kept separate from CommonController.role
  /// so we only commit the global role once the user hits Continue.
  final Rx<UserRole?> selectedRole = Rx<UserRole?>(null);

  bool get canContinue => selectedRole.value != null;

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
    if (role == null) return;

    CommonController.to.setRole(role);
    AppRouter.route.goNamed(RoutePath.onboardingScreen);
  }
}
