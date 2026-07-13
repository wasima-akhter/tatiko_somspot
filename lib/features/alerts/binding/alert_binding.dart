import 'package:get/get.dart';

import '../controller/alerts_controller.dart';

class AlertBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlertsScreenController>(() => AlertsScreenController());
  }
}
