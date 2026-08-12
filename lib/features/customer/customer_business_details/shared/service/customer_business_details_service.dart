import '../../../../../share/export/service_export.dart';
import '../../../../../share/model/pagination_meta_model.dart';
import '../../../../../share/widgets/paginator/paginator.dart';
import '../model/deal_model.dart';
import '../model/customer_buiness_details_model.dart';
import '../repository/customer_business_details_repository.dart';

class CustomerBusinessDetailsService {
  final CustomerBusinessDetailsRepository _repository;

  CustomerBusinessDetailsService(this._repository);

  Future<ApiResponse<BusinessDetailsModel>> getBusinessDetails(
    String businessId,
  ) async {
    try {
      final response = await _repository.getBusinessDetails(businessId);

      return ApiParser.parse<BusinessDetailsModel>(
        response,
        mapper: (json) => BusinessDetailsModel.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Business Details Error => $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  //

  // ============================================================
  // Offers
  // ============================================================

  Future<ApiResponse<PaginatedResult<DealModel>>> getOffers({
    int page = 1,
    int limit = 10,
    String status = "",
  }) async {
    try {
      final response = await _repository.getOffers(
        page: page,
        limit: limit,
        status: status,
      );

      final data = response.data['data'];

      return ApiResponse.success(
        data: PaginatedResult<DealModel>(
          data: List<DealModel>.from(
            (data['result'] as List).map((e) => DealModel.fromJson(e)),
          ),
          meta: PaginationMeta.fromJson(data['meta']),
          summary: data['summary'] != null
              ? SummaryModel.fromJson(data['summary'])
              : null,
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Offers Error => $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}
