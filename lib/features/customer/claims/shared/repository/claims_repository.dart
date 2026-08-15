// -----------------------------------------------------------------------------
// 2. Claims Repository (`claims_repository.dart`)
// -----------------------------------------------------------------------------
import '../../../../../share/export/repo_export.dart';

class ClaimsRepository {
  final ApiClient _apiClient;

  ClaimsRepository(this._apiClient);

  Future<Response> getClaimWallet({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    final queryParameters = <String, dynamic>{'page': page, 'limit': limit};

    if (status != null && status.isNotEmpty) {
      queryParameters['status'] = status;
    }

    return await _apiClient.get(
      url: ApiUrls.claimWalletList(),
      queryParams: queryParameters,
    );
  }
}
