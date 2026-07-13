import 'app_storage.dart';

class TokenManager {
  static bool get isAccessTokenExpired {
    final expiry = AppStorage.to.tokenExpiry;

    if (expiry == 0) {
      return true;
    }

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return now >= expiry;
  }

  static bool get isRefreshTokenExpired {
    final expiry = AppStorage.to.refreshTokenExpiry;

    if (expiry == 0) {
      return true;
    }

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return now >= expiry;
  }
}
