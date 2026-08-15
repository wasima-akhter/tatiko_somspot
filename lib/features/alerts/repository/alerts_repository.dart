import '../../../share/export/repo_export.dart';

class AlertsRepository {
  final ApiClient _apiClient;

  AlertsRepository(this._apiClient);

  Future<Response> getAllNotifications({int page = 1, int limit = 10}) {
    return _apiClient.get(
      showResponse: true,
      url: ApiUrls.getAllNotifications(),
      queryParams: {'page': page, 'limit': limit},
    );
  }

  Future<Response> markAllNotificationsAsRead() {
    return _apiClient.patch(
      showResponse: true,
      url: ApiUrls.markNotificationsAsRead(),
      body: {'isRead': true},
    );
  }
}
