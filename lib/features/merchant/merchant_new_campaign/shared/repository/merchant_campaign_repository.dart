import 'package:flutter/material.dart';

import '../../../../../share/export/repo_export.dart';
import '../request/new_campaign_request.dart';

class MerchantCampaignRepository {
  final ApiClient _apiClient;

  MerchantCampaignRepository(this._apiClient);

  Future<Response> createNewCampaign(CreateCampaignRequest request) {
    return _apiClient.post(
      url: ApiUrls.createMerchantCampaign(),
      body: request.toJson(),
    );
  }

  Future<Response> getCampaigns({
    int page = 1,
    int limit = 10,
    String status = "",
  }) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.merchantCampaigns(),

      queryParams: (status.isEmpty)
          ? {'page': page, 'limit': limit}
          : {'page': page, 'limit': limit, 'status': status},
    );
  }

  Future<Response> getCampaignDetails(String campaignId) {
    return _apiClient.get(
      url: ApiUrls.merchantCampaignDetails(),
      queryParams: {"campaignId": campaignId},
    );
  }

  //
  Future<Response> getCampaignApplications({
    required String campaignId,
    int page = 1,
    int limit = 10,
  }) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.campaignApplications(),
      queryParams: {"campaignId": campaignId, "page": page, "limit": limit},
    );
  }

  Future<Response> assignedInfluencerDetail(String userId) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.merchantCampaignAssignedInfluencerDetail(),
      queryParams: {"userId": userId},
    );
  }

  /// Content tab in campaign-details screen
  Future<Response> getCampaignContents({
    required String campaignId,
    required String status,
    int page = 1,
    int limit = 10,
  }) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.campaignContents(),
      queryParams: {
        "campaignId": campaignId,
        "hasContent": true,

        "page": page,
        "limit": limit,
      },
    );
  }

  Future<Response> updateContentStatus({
    required String contentId,
    required String action,
    String? rejectionReason,
  }) {
    return _apiClient.patch(
      url: ApiUrls.actionOnCampaignContent(),
      showResponse: true,
      body: {
        "applicationId": contentId,
        "action": action,
        "merchantNote": ?rejectionReason,
      },
    );
  }

  // content details
  Future<Response> getCampaignContentDetails({
    required String applicationId,
  }) async {
    debugPrint('loadContentDetails--> repo request start: $applicationId');

    final response = await _apiClient.get(
      showResponse: true,
      url: ApiUrls.campaignContentDetails(),
      skipAuth: false,
      queryParams: {"applicationId": applicationId, "hasContent": true},
    );

    debugPrint('loadContentDetails--> repo response: ${response.statusCode}');

    debugPrint('loadContentDetails--> repo body: ${response.data}');

    return response;
  }

  //
  Future<Response> verifyPublication({
    required String applicationId,
    required String action,
  }) {
    return _apiClient.patch(
      url: ApiUrls.verifyPublication(),
      showResponse: true,
      body: {"applicationId": applicationId, "action": action},
    );
  }
}
