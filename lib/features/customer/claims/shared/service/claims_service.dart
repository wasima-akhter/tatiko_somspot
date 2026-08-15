// -----------------------------------------------------------------------------
// 3. Claims Service (`claims_service.dart`)
// -----------------------------------------------------------------------------
import '../../../../../share/export/service_export.dart';
import '../../../../../share/model/pagination_meta_model.dart';
import '../../../../../share/widgets/paginator/paginator.dart';
import '../repository/claims_repository.dart';
import '../response/claims_model.dart';

class ClaimsService {
  final ClaimsRepository _repository;

  ClaimsService(this._repository);

  /// Get user claimed vouchers wallet.
  Future<ApiResponse<PaginatedResult<ClaimWalletItemModel>>> getClaimWallet({
    String? status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _repository.getClaimWallet(
        status: status,
        page: page,
        limit: limit,
      );

      final data = response.data['data'];

      if (data is! Map) {
        return ApiResponse.failure(message: "Invalid claim wallet response");
      }

      final result = data['result'];

      final items = result is List
          ? result
                .whereType<Map>()
                .map(
                  (e) => ClaimWalletItemModel.fromJson(
                    Map<String, dynamic>.from(e),
                  ),
                )
                .toList()
          : <ClaimWalletItemModel>[];

      final meta = data['meta'] is Map
          ? PaginationMeta.fromJson(Map<String, dynamic>.from(data['meta']))
          : PaginationMeta.fromJson({});

      return ApiResponse.success(
        data: PaginatedResult<ClaimWalletItemModel>(data: items, meta: meta),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Claim Wallet Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}
