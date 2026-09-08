import '../../../../share/export/service_export.dart';
import '../../../../share/model/pagination_meta_model.dart';
import '../../../../share/widgets/paginator/paginator.dart';
import '../../../core/business/response/business-response.dart';
import '../../../offers/shared/response/offers_response.dart';
import '../model/home_content_creator_model.dart';
import '../repository/customer_home_repository.dart';

class CustromerHomeService {
  final HomeContentRepository _repository;

  CustromerHomeService(this._repository);

  Future<ApiResponse<PaginatedResult<CreatorContentModel>>> getCreatorContent({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _repository.getCreatorContent(
        page: page,
        limit: limit,
      );

      final data = response.data['data'];

      return ApiResponse.success(
        data: PaginatedResult<CreatorContentModel>(
          data: List<CreatorContentModel>.from(
            (data['result'] as List<dynamic>? ?? []).map(
              (e) => CreatorContentModel.fromJson(e),
            ),
          ),
          meta: PaginationMeta.fromJson(data['meta']),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint('Get Creator Content Error: $e');
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: 'Something went wrong');
    }
  }

  //
  Future<ApiResponse<PaginatedResult<BusinessModel>>> getNearbyBusinesses({
    required double lat,
    required double lng,
    int page = 1,
    int limit = 10,
    double radiusKm = 10,
    String? category,
    required BusinessLocationMode locationMode,
  }) async {
    try {
      final response = await _repository.getNearbyBusinesses(
        lat: lat,
        lng: lng,
        page: page,
        limit: limit,
        radiusKm: radiusKm,
        category: category,
        locationMode: locationMode,
      );

      final data = response.data['data'];

      return ApiResponse.success(
        data: PaginatedResult<BusinessModel>(
          data: List<BusinessModel>.from(
            data['result'].map((e) => BusinessModel.fromJson(e)),
          ),
          meta: PaginationMeta.fromJson(data['meta']),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint('Get Nearby Businesses Error $e');
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: 'Something went wrong');
    }
  }

  Future<ApiResponse<PaginatedResult<OfferModel>>> getTopDeals({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _repository.getTopDeals(page: page, limit: limit);

      final data = response.data['data'];

      return ApiResponse.success(
        data: PaginatedResult<OfferModel>(
          data: List<OfferModel>.from(
            data['result'].map((e) => OfferModel.fromJson(e)),
          ),
          meta: PaginationMeta.fromJson(data['meta']),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint('Get Top Deals Error: $e');
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: 'Something went wrong');
    }
  }
}
