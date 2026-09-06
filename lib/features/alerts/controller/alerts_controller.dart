import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/snackbar/api_snackbar.dart';
import '../../../share/widgets/paginator/paginator.dart';
import '../../../utils/enum/app_enum.dart';
import '../model/alerts_model.dart';
import '../service/alerts_service.dart';

class AlertsScreenController extends GetxController {
  final AlertsService _service;

  AlertsScreenController(this._service);

  static AlertsScreenController get to => Get.find();

  final listScrollController = ScrollController();

  late final Paginator<NotificationModel> paginator;

  @override
  void onInit() {
    super.onInit();

    paginator = Paginator(
      fetchPage: (page, limit) async {
        try {
          final response = await _service.getAllNotifications(
            page: page,
            limit: limit,
          );

          return response.data!;
        } catch (e) {
          rethrow;
        }
      },
    );

    listScrollController.addListener(() {
      if (!listScrollController.hasClients) return;

      final position = listScrollController.position;

      if (position.pixels >= position.maxScrollExtent - 200) {
        if (paginator.hasMore.value &&
            paginator.loadMoreStatus.value != ApiStatus.loading) {
          loadMore();
        }
      }
    });

    loadNotifications();
  }

  @override
  void onClose() {
    listScrollController.dispose();
    paginator.dispose();
    super.onClose();
  }

  Future<void> loadNotifications() {
    return paginator.loadInitial();
  }

  Future<void> loadMore() {
    return paginator.loadMore();
  }

  Future<void> refreshNotifications() {
    return paginator.refresh();
  }

  List<NotificationModel> get notifications => paginator.items;
  final markAllStatus = ApiStatus.completed.obs;
  final markAllErrorMessage = ''.obs;

  //
  Future<void> markAllAsRead() async {
    if (markAllStatus.value == ApiStatus.loading) return;

    markAllStatus.value = ApiStatus.loading;
    markAllErrorMessage.value = '';

    try {
      final response = await _service.markAllNotificationsAsRead();

      if (response.success) {
        for (final notification in paginator.items) {
          notification.isUnread.value = false;
        }

        markAllStatus.value = ApiStatus.completed;

        ApiSnackbar.show(response.message, type: SnackbarType.success);
      } else {
        markAllStatus.value = ApiStatus.error;
        markAllErrorMessage.value = response.message;

        ApiSnackbar.show(response.message);
      }
    } catch (e, s) {
      markAllStatus.value = ApiStatus.error;
      markAllErrorMessage.value = 'Something went wrong';

      debugPrint('Mark All Notifications As Read Error => $e');
      debugPrintStack(stackTrace: s);

      ApiSnackbar.show('Something went wrong');
    }
  }

  void toggleUnread(int index) {
    paginator.items[index].isUnread.toggle();
  }
}
