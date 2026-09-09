import 'package:get/get.dart';

import '../../../../share/export/service_export.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../repository/stats_repository.dart';
import '../response/stats_response.dart';

class StatsService {
  final StatsRepository _repository;

  StatsService(this._repository);

  Future<ApiResponse<MerchantAnalyticsResponse>> merchantAnalytics() async {
    try {
      final response = await _repository.merchantAnalytics();

      return ApiResponse.success(
        data: MerchantAnalyticsResponse.fromJson(response.data["data"]),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Merchant Analytics Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
