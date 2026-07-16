import '../config/app_config.dart';

class ApiUrls {
  static const String base = AppConfig.baseURL;

  // =========================
  // Auth
  // =========================

  static String register() => '$base/auth/register';

  static String activationCodeResend() => '$base/auth/activation-code-resend';

  static String activateAccount() => '$base/auth/activate-account';

  static String login() => '$base/auth/login';

  static String me() => '$base/auth/me';

  static String logout() => '$base/auth/logout';

  // =========================
  // Phone OTP
  // =========================

  static String requestPhoneOtp() => '$base/auth/phone/request-otp';

  static String verifyPhoneOtp() => '$base/auth/phone/verify-otp';

  // =========================
  // Password
  // =========================

  static String forgotPassword() => '$base/auth/forgot-password';

  static String verifyForgetPasswordOtp() =>
      '$base/auth/forget-pass-otp-verify';

  static String resetPassword() => '$base/auth/reset-password';

  static String changePassword() => '$base/auth/change-password';

  // profile
  static String editProfile() => '$base/user/edit-profile';

  static String userProfile() => '$base/user/profile';

  // business profile
  static String createBusiness() => '$base/business/create';

  // core
  // categories
  static String getCategories() => '$base/category/get-all';
}
