import 'package:get/get.dart';

import '../../../core/di/injection.dart';
import '../controller/auth_controller.dart';
import '../service/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(sl<AuthService>()));
  }
}
