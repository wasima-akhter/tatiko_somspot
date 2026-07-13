import 'package:get/get.dart';

import '../main_profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
