import 'package:dio/dio.dart';

import '../../../../../share/export/service_export.dart';
import '../../../../../share/model/pagination_meta_model.dart';
import '../../../../../share/widgets/paginator/paginator.dart';
import '../repository/merchant_campaign_repository.dart';
import '../request/new_campaign_request.dart';
import '../response/merchant_campaign_detail_model.dart';
import '../response/merchant_campaign_model.dart';

class MerchantCampaignService {
  final MerchantCampaignRepository _repository;

  MerchantCampaignService(this._repository);

  Future<ApiResponse<Response>> createNewCampaign(
    CreateCampaignRequest request,
  ) async {
    try {
      final response = await _repository.createNewCampaign(request);

      return ApiResponse.success(data: response);
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Create Offer Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<PaginatedResult<MerchantCampaignModel>>> getCampaigns({
    int page = 1,
    int limit = 10,
    String status = "all",
  }) async {
    try {
      final response = await _repository.getCampaigns(
        page: page,
        limit: limit,
        status: status,
      );

      final data = response.data['data'];

      return ApiResponse.success(
        data: PaginatedResult<MerchantCampaignModel>(
          data: List<MerchantCampaignModel>.from(
            data['result'].map((e) => MerchantCampaignModel.fromJson(e)),
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
      debugPrint("Get Campaigns Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<MerchantCampaignDetailsModel>> getCampaignDetails(
    String campaignId,
  ) async {
    try {
      final response = await _repository.getCampaignDetails(campaignId);

      return ApiParser.parse<MerchantCampaignDetailsModel>(
        response,

        mapper: (json) => MerchantCampaignDetailsModel.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Campaign Details Error $e");

      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  //
  Future<ApiResponse<PaginatedResult<CampaignApplicationModel>>>
  getCampaignApplications({
    required String campaignId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _repository.getCampaignApplications(
        campaignId: campaignId,
        page: page,
        limit: limit,
      );

      final data = response.data["data"];

      return ApiResponse.success(
        data: PaginatedResult<CampaignApplicationModel>(
          data: List<CampaignApplicationModel>.from(
            (data["result"] ?? []).map(
              (e) => CampaignApplicationModel.fromJson(e),
            ),
          ),

          meta: PaginationMeta.fromJson(data["meta"]),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Campaign Applications Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }

  Future<ApiResponse<MerchantCreatorModel>> assignedInfluencerDetail(
    String userId,
  ) async {
    try {
      final response = await _repository.assignedInfluencerDetail(userId);

      return ApiParser.parse<MerchantCreatorModel>(
        response,
        mapper: (json) => MerchantCreatorModel.fromJson(json),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Creator Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: "Something went wrong");
    }
  }
}
