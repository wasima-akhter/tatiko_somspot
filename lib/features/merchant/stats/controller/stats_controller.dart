import 'package:get/get.dart';

import '../../../../utils/enum/app_enum.dart';
import '../response/stats_response.dart';
import '../service/stats_service.dart';

class StatsController extends GetxController {
  final StatsService _service;

  StatsController(this._service);

  static StatsController get to => Get.find();

  final status = ApiStatus.loading.obs;

  final errorMessage = RxnString();

  final analytics = Rxn<MerchantAnalyticsResponse>();

  List<TopOfferModel> get topOffers => analytics.value?.topOffers ?? [];

  List<ClaimTrendModel> get claimsTrend => analytics.value?.claimsTrend ?? [];

  @override
  void onInit() {
    super.onInit();
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    try {
      status.value = ApiStatus.loading;

      final response = await _service.merchantAnalytics();

      if (response.success) {
        analytics.value = response.data;
        status.value = ApiStatus.completed;
      } else {
        errorMessage.value = response.message;
        status.value = ApiStatus.error;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      status.value = ApiStatus.error;
    }
  }
}
