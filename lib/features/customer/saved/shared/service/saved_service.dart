import 'package:get/get.dart';

import '../../../../../share/export/service_export.dart';
import '../../../../../share/model/pagination_meta_model.dart';
import '../../../../../share/widgets/paginator/paginator.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../repository/saved_repository.dart';
import '../response/saved_business_model.dart';
import '../response/saved_offer_model.dart';
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

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  /// Get saved businesses.
  Future<ApiResponse<PaginatedResult<SavedBusinessModel>>> getSavedBusinesses({
    int page = 1,
    int limit = 10,
  }) async {
    return getSavedItems<SavedBusinessModel>(
      type: 'business',
      page: page,
      limit: limit,
      fromJson: SavedBusinessModel.fromJson,
    );
  }

  /// Get saved offers/deals.
  Future<ApiResponse<PaginatedResult<SavedOfferModel>>> getSavedOffers({
    int page = 1,
    int limit = 10,
  }) async {
    return getSavedItems<SavedOfferModel>(
      type: 'offer',
      page: page,
      limit: limit,
      fromJson: SavedOfferModel.fromJson,
    );
  }

  /// Get saved businesses or offers by type.
  Future<ApiResponse<PaginatedResult<T>>> getSavedItems<T>({
    required String type,
    required T Function(Map<String, dynamic> json) fromJson,
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

      if (data is! Map) {
        return ApiResponse.failure(message: "Invalid saved items response");
      }

      final result = data['result'];

      final items = result is List
          ? result
                .whereType<Map>()
                .map((e) => fromJson(Map<String, dynamic>.from(e)))
                .toList()
          : <T>[];

      final meta = data['meta'] is Map
          ? PaginationMeta.fromJson(Map<String, dynamic>.from(data['meta']))
          : PaginationMeta.fromJson({});

      return ApiResponse.success(
        data: PaginatedResult<T>(data: items, meta: meta),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Saved $type Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
