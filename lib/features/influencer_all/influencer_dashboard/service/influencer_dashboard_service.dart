import 'package:get/get.dart';

import '../../../../share/export/service_export.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../repository/influencer_dashboard_repository.dart';
import '../response/influencer_dashboard_response.dart';

class InfluencerDashboardService {
  final InfluencerDashboardRepository _repository;

  InfluencerDashboardService(this._repository);

  Future<ApiResponse<InfluencerDashboardModel>> getInfluencerDashboard() async {
    try {
      final response = await _repository.influencerDashboard();

      final result = ApiParser.parse<InfluencerDashboardModel>(
        response,
        mapper: (json) => InfluencerDashboardModel.fromJson(json),
      );

      return result;
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Influencer Dashboard Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
