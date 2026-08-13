import '../../../../../share/export/service_export.dart';
import '../../../../../share/model/pagination_meta_model.dart';
import '../../../../../share/widgets/paginator/paginator.dart';
import '../repository/saved_repository.dart';
import '../response/toggole_saved_response.dart';

class SavedService {
  final SavedRepository _repository;

  SavedService(this._repository);

  /// Toggle bookmark for a business or offer.
  ///
  /// Provide either [businessId] or [offerId].
  Future<ApiResponse<ToggleSavedModel>> toggleSaved({
    String? businessId,
    String? offerId,
  }) async {
    try {
      final response = await _repository.toggleSaved(
        businessId: businessId,
        offerId: offerId,
      );

      final data = response.data['data'];

      return ApiResponse.success(data: ToggleSavedModel.fromJson(data));
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Toggle Saved Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  /// Get saved businesses.
  Future<ApiResponse<PaginatedResult<Map<String, dynamic>>>>
  getSavedBusinesses({int page = 1, int limit = 10}) async {
    return getSavedItems(type: 'business', page: page, limit: limit);
  }

  /// Get saved offers/deals.
  Future<ApiResponse<PaginatedResult<Map<String, dynamic>>>> getSavedOffers({
    int page = 1,
    int limit = 10,
  }) async {
    return getSavedItems(type: 'offer', page: page, limit: limit);
  }

  /// Get saved businesses or offers by type.
  Future<ApiResponse<PaginatedResult<Map<String, dynamic>>>> getSavedItems({
    required String type,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      if (type != 'business' && type != 'offer') {
        return ApiResponse.failure(message: "Invalid saved item type");
      }

      final response = await _repository.getSavedItems(
        type: type,
        page: page,
        limit: limit,
      );

      final data = response.data['data'];

      return ApiResponse.success(
        data: PaginatedResult<Map<String, dynamic>>(
          data: List<Map<String, dynamic>>.from(
            (data['result'] ?? []).map((e) => Map<String, dynamic>.from(e)),
          ),
          meta: PaginationMeta.fromJson(data['meta']),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Saved Items Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}
