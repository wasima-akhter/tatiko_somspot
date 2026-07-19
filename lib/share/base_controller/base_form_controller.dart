import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/toast/toast_helper.dart';
import '../../utils/enum/app_enum.dart';

abstract class BaseFormController extends GetxController {
  final submitLoading = ApiStatus.completed.obs;
  final RxnString errorMessage = RxnString();

  void setLoading(ApiStatus status) {
    submitLoading.value = status;
  }

  void beginSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    errorMessage.value = null;
    setLoading(ApiStatus.loading);
  }

  void submitSuccess() {
    setLoading(ApiStatus.completed);
  }

  void submitFailure(String? message) {
    errorMessage.value = message;
    setLoading(ApiStatus.error);
  }

  void resetForm({
    required GlobalKey<FormState> formKey,
    List<TextEditingController> controllers = const [],
    List<VoidCallback> extraReset = const [],
  }) {
    formKey.currentState?.reset();

    for (final controller in controllers) {
      controller.clear();
    }

    for (final reset in extraReset) {
      reset();
    }
  }

  void showSuccess(String message) {
    AppToast.success(message: message);
  }
}
