import 'package:get/get.dart';

class ApiSnackbar {
  static void show(String message, {bool enabled = false}) {
    if (!enabled) return;

    Get.snackbar("Error", message, snackPosition: SnackPosition.BOTTOM);
  }
}
