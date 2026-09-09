import '../../../../../share/export/service_export.dart';
import '../repository/customer_search_repository.dart';
import '../response/customer_search_response.dart';

class CustomerSearchService {
  final CustomerSearchRepository _repository;

  CustomerSearchService(this._repository);

  /// Search business or deal
  Future<ApiResponse<CustomerSearchResponseModel>> search({
    required String term,
  }) async {
    try {
      final response = await _repository.search(term: term);

      return ApiParser.parse<CustomerSearchResponseModel>(
        response,
        mapper: (json) => CustomerSearchResponseModel.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print('Customer Search Error $e');
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: 'Something went wrong');
    }
  }

  /// Get recent search history
  Future<ApiResponse<List<RecentSearchModel>>> getRecentSearches() async {
    try {
      final response = await _repository.getRecentSearches();

      final data = response.data['data'] ?? [];

      return ApiResponse.success(
        data: List<RecentSearchModel>.from(
          data.map((e) => RecentSearchModel.fromJson(e)),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print('Get Recent Searches Error $e');
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: 'Something went wrong');
    }
  }

  /// Clear recent search history
  Future<ApiResponse<int>> clearRecentSearches() async {
    try {
      final response = await _repository.clearRecentSearches();

      final data = response.data['data'];

      return ApiResponse.success(
        data: (data?['cleared'] as num?)?.toInt() ?? 0,
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print('Clear Recent Searches Error $e');
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: 'Something went wrong');
    }
  }

  /// Get trending search keywords
  Future<ApiResponse<List<TrendingSearchModel>>> getTrendingSearches() async {
    try {
      final response = await _repository.getTrendingSearches();

      final data = response.data['data'] ?? [];

      return ApiResponse.success(
        data: List<TrendingSearchModel>.from(
          data.map((e) => TrendingSearchModel.fromJson(e)),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print('Get Trending Searches Error $e');
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: 'Something went wrong');
    }
  }
}
