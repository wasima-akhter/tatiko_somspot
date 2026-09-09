import 'package:get/get.dart';
import 'package:som_spot/features/merchant/dashboard_merchant/repository/dashboard_merchant_repository.dart';

import '../../../../share/export/service_export.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../response/dashboard_merchant_response.dart';

class DashboardMerchantService {
  final DashboardMerchantRepository _repository;

  DashboardMerchantService(this._repository);

  Future<ApiResponse<MerchantDashboardModel>> getMerchantDashboard() async {
    try {
      final response = await _repository.merchantDashboard();

      final result = ApiParser.parse<MerchantDashboardModel>(
        response,
        mapper: (json) => MerchantDashboardModel.fromJson(json),
      );

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Merchant Dashboard Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
