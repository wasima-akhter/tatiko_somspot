import '../../../../helper/qr_code/qr_code_helper.dart';
import '../../../../share/export/screen_export.dart';

class OfferClaimController extends GetxController {
  final String claimCode;

  OfferClaimController({required this.claimCode});

  static OfferClaimController get to => Get.find();

  void onDone() {
    AppRouter.route.pop();
  }

  // Inside OfferClaimController
  final isDownloading = false.obs;

  Future<void> downloadQrCode(BuildContext context) async {
    print('claim: $claimCode');
    isDownloading.value = true;
    try {
      await QrCodeHelper.download(
        context,
        claimCode,
        fileName: 'claim_$claimCode',
      );
    } finally {
      isDownloading.value = false;
    }
  }
}
