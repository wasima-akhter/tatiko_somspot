import 'package:get/get.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../utils/enum/app_enum.dart';
import '../helper/influencer_wallet_helper.dart';
import '../response/influencer_wallet_response.dart';
import '../service/influencer_wallet_service.dart';

class InfluencerWalletController extends GetxController {
  final InfluencerWalletService _service;

  InfluencerWalletController(this._service);

  static InfluencerWalletController get to => Get.find();

  final selectedTab = InfluencerWalletTab.analytics.obs;

  List<InfluencerWalletTab> get tabs => InfluencerWalletTab.values;

  void changeTab(InfluencerWalletTab tab) {
    selectedTab.value = tab;
  }

  final walletStatus = ApiStatus.loading.obs;

  final errorMessage = RxnString();

  InfluencerWalletResponse? walletData;

  @override
  void onInit() {
    super.onInit();

    getWalletAnalytics();
  }

  final selectedPeriod = WalletAnalyticsPeriod.thirtyDays.obs;

  List<WalletAnalyticsPeriod> get periods => WalletAnalyticsPeriod.values;

  void changePeriod(WalletAnalyticsPeriod period) {
    selectedPeriod.value = period;

    getWalletAnalytics(period: period.apiValue);
  }

  Future<void> getWalletAnalytics({String period = "30d"}) async {
    walletStatus.value = ApiStatus.loading;

    errorMessage.value = null;

    try {
      final result = await _service.getWalletAnalytics(period: period);

      if (!result.success) {
        errorMessage.value = result.message;

        walletStatus.value = ApiStatus.error;

        return;
      }

      if (result.data == null) {
        walletStatus.value = ApiStatus.noDataFound;

        return;
      }

      walletData = result.data;

      walletStatus.value = ApiStatus.completed;
    } catch (e) {
      errorMessage.value = AppStrings.somethingWentWrong.tr;

      walletStatus.value = ApiStatus.error;
    }
  }
}
