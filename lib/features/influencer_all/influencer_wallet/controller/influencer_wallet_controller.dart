import 'package:get/get.dart';

class InfluencerWalletController extends GetxController {
  static InfluencerWalletController get to => Get.find();
  RxInt selectedTab = 1.obs;

  final tabs = ["Withdraw", "Analytics"];

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
