import 'package:get/get.dart';

import '../../choose_role/controller/choose_role_controller.dart';
import '../controller/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());

    Get.lazyPut(() => ChooseRoleController());
  }
}
