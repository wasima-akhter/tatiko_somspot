import 'package:flutter/material.dart';

import '../../utils/app_keys/app_keys.dart';

enum SnackbarType { success, error, warning, info }

class ApiSnackbar {
  static void show(String message, {SnackbarType type = SnackbarType.error}) {
    final messenger = AppKeys.scaffoldMessengerKey.currentState;

    if (messenger == null) {
      debugPrint("Snackbar unavailable: $message");
      return;
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,

          margin: const EdgeInsets.all(16),

          duration: const Duration(seconds: 3),

          backgroundColor: _color(type),

          content: Text(message, style: const TextStyle(color: Colors.white)),
        ),
      );
  }

  static Color _color(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return Colors.green;

      case SnackbarType.error:
        return Colors.red;

      case SnackbarType.warning:
        return Colors.orange;

      case SnackbarType.info:
        return Colors.blue;
    }
  }
}
