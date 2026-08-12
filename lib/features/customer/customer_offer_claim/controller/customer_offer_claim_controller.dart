import '../../../../share/controller/screen_export.dart';

class OfferClaimController extends GetxController {
  final String claimCode;

  OfferClaimController({required this.claimCode});

  static OfferClaimController get to => Get.find();

  void onDone() {
    AppRouter.route.pop();
  }
}
