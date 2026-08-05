import '../../../../share/export/service_export.dart';
import '../../../../share/widgets/paginator/paginator.dart';
import '../repository/business-repository.dart';
import '../request/business-request.dart';
import '../response/business-response.dart';

class BusinessService {
  final BusinessRepository _repository;

  BusinessService(this._repository);

  Future<PaginatedResult<BusinessModel>> getMyBusinesses(
    int page,
    int limit,
  ) async {
    try {
      final response = await _repository.getMyBusinesses(
        page: page,
        limit: limit,
      );

      final json = response.data["data"];

      final data = BusinessPaginationResponse.fromJson(json);

      return PaginatedResult(data: data.businesses, meta: data.meta);
    } catch (e, s) {
      debugPrint("Get My Business Error: $e");

      debugPrintStack(stackTrace: s);

      rethrow;
    }
  }

  //
  Future<ApiResponse<void>> updateBusinessProfile(
    EditBusinessRequest request,
  ) async {
    try {
      final response = await _repository.updateBusiness(request: request);

      return ApiParser.parse<void>(response, mapper: (_) {});
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Update Business Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}
