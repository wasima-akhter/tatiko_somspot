import 'package:get/get.dart';

import '../../../../share/export/service_export.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../repository/influencer_wallet_repository.dart';
import '../response/influencer_wallet_response.dart';

class InfluencerWalletService {
  final InfluencerWalletRepository _repository;

  InfluencerWalletService(this._repository);

  Future<ApiResponse<InfluencerWalletResponse>> getWalletAnalytics({
    String period = "30d",
  }) async {
    try {
      final response = await _repository.walletAnalytics(period: period);

      return ApiParser.parse<InfluencerWalletResponse>(
        response,
        mapper: (json) => InfluencerWalletResponse.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Influencer Wallet Error $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
