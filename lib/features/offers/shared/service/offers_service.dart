import 'package:get/get.dart';

import '../../../../share/export/service_export.dart';
import '../../../../share/model/pagination_meta_model.dart';
import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../../utils/multipart/multipart_body.dart';
import '../../../offers/shared/response/offers_response.dart';
import '../repository/offers_repository.dart';
import '../request/offers_request.dart';
import '../response/claimed_offer_model.dart';

class OfferService {
  final OfferRepository _repository;

  OfferService(this._repository);

  Future<ApiResponse<OfferModel>> createOffer(
    CreateOfferRequest request,
  ) async {
    try {
      final response = await _repository.createOffer(request);

      return ApiParser.parse<OfferModel>(
        response,
        mapper: (json) => OfferModel.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Create Offer Error $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<PaginatedResult<OfferModel>>> getOffers({
    int page = 1,
    int limit = 10,
    String status = "active",
  }) async {
    try {
      final response = await _repository.getOffers(
        page: page,
        limit: limit,
        status: status,
      );

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
      print("Get Offers Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<OfferModel>> getOfferDetails(String offerId) async {
    try {
      final response = await _repository.getOfferDetails(offerId);

      return ApiParser.parse<OfferModel>(
        response,
        mapper: (json) => OfferModel.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Get Offer Details Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<OfferModel>> updateOffer({
    required UpdateOfferRequest request,
    List<MultipartBody>? files,
  }) async {
    try {
      final response = await _repository.updateOffer(
        request: request,
        files: files,
      );

      return ApiParser.parse<OfferModel>(
        response,
        mapper: (json) => OfferModel.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Update Offer Error: $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  // ============================================================
  // Claim Offer
  // ============================================================

  Future<ApiResponse<ClaimOfferModel>> claimOffer(String offerId) async {
    try {
      final response = await _repository.claimOffer(offerId);

      final data = response.data['data'];
      final model = ClaimOfferModel.fromJson(Map<String, dynamic>.from(data));

      print('CLAIM MODEL CODE: ${model.code}');
      return ApiResponse.success(
        data: model,
        message: response.data['message'] ?? '',
        statusCode: response.data['statusCode'],
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Claim Offer Error => $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
