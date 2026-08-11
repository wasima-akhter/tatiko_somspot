import '../../../../share/export/service_export.dart';
import '../../../../share/model/pagination_meta_model.dart';
import '../../../../share/widgets/paginator/paginator.dart';
import '../../../core/business/response/business-response.dart';
import '../model/home_content_creator_model.dart';
import '../repository/customer_home_repository.dart';

class HomeContentService {
  final HomeContentRepository _repository;

  HomeContentService(this._repository);

  Future<ApiResponse<List<CreatorContentModel>>> getCreatorContent() async {
    try {
      final response = await _repository.getCreatorContent();

      final data = response.data['data'] as List<dynamic>? ?? [];

      final contents = data
          .whereType<Map<String, dynamic>>()
          .map(CreatorContentModel.fromJson)
          .toList();

      return ApiResponse.success(data: contents);
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
  }) async {
    try {
      final response = await _repository.getNearbyBusinesses(
        lat: lat,
        lng: lng,
        page: page,
        limit: limit,
        radiusKm: radiusKm,
        category: category,
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
}
