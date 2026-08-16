import 'package:get/get.dart';

import '../../../share/export/service_export.dart';
import '../../../share/model/pagination_meta_model.dart';
import '../../../share/widgets/paginator/paginator.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../model/alerts_model.dart';
import '../repository/alerts_repository.dart';

class AlertsService {
  final AlertsRepository _repository;

  AlertsService(this._repository);

  Future<ApiResponse<PaginatedResult<NotificationModel>>> getAllNotifications({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _repository.getAllNotifications(
        page: page,
        limit: limit,
      );

      final data = response.data['data'];

      return ApiResponse.success(
        data: PaginatedResult<NotificationModel>(
          data: List<NotificationModel>.from(
            data['result'].map((e) => NotificationModel.fromJson(e)),
          ),
          meta: PaginationMeta.fromJson(data['meta']),
        ),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Get Notifications Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  Future<ApiResponse<bool>> markAllNotificationsAsRead() async {
    try {
      await _repository.markAllNotificationsAsRead();

      return ApiResponse.success(data: true);
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      debugPrint("Mark Notifications Read Error $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
