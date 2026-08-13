import '../../../../../share/export/repo_export.dart';

class SavedRepository {
  final ApiClient _apiClient;

  SavedRepository(this._apiClient);

  /// Toggle saved/bookmarked status for a business or offer.
  ///
  /// Pass either [businessId] or [offerId], but not both.
  Future<Response> toggleSaved({String? businessId, String? offerId}) {
    final body = <String, dynamic>{};

    if (businessId != null && businessId.isNotEmpty) {
      body['businessId'] = businessId;
    } else if (offerId != null && offerId.isNotEmpty) {
      body['offerId'] = offerId;
    } else {
      throw ArgumentError('Item was not identified');
    }

    return _apiClient.post(
      url: ApiUrls.toggleSaving(),
      showResponse: true,
      body: body,
    );
  }

  /// Get saved businesses or offers.
  ///
  /// [type] must be either `business` or `offer`.
  Future<Response> getSavedItems({
    required String type,
    int page = 1,
    int limit = 10,
  }) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.getSavedItems(),
      queryParams: {'type': type, 'page': page, 'limit': limit},
    );
  }
}
