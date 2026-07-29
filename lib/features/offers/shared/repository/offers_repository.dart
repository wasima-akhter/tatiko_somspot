import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../../share/export/repo_export.dart';
import '../../../../utils/multipart/multipart_body.dart';
import '../request/offers_request.dart';

class OfferRepository {
  final ApiClient _apiClient;

  OfferRepository(this._apiClient);

  Future<Response> createOffer(CreateOfferRequest request) {
    return _apiClient.post(url: ApiUrls.createOffer(), body: request.toJson());
  }

  Future<Response> getOffersBybusinessId({
    required String businessId,
    int page = 1,
    int limit = 10,
    String status = "active",
  }) async {
    return await _apiClient.get(
      url: ApiUrls.getOffers(),

      queryParams: {
        "business": businessId,

        "page": page,

        "limit": limit,

        "status": status,
      },
    );
  }

  Future<Response> getOffers({
    int page = 1,
    int limit = 10,
    String status = "active",
  }) async {
    return await _apiClient.get(
      showResponse: true,
      url: CommonController.to.isMerchandiser
          ? ApiUrls.getMerchantOffers()
          : ApiUrls.getOffers(),

      queryParams: {"page": page, "limit": limit, "status": status},
    );
  }

  Future<Response> getOfferDetails(String offerId) {
    return _apiClient.get(
      url: ApiUrls.getOfferDetails(),
      queryParams: {'offerId': offerId},
    );
  }

  Future<Response> updateOffer({
    required UpdateOfferRequest request,
    List<MultipartBody>? files,
  }) {
    return _apiClient.uploadMultipart(
      url: ApiUrls.updateOffer(),
      method: "PATCH",
      files: files ?? [],
      fields: request.toJson().map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  //
}
