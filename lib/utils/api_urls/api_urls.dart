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

  static String influencerProfile() => "$base/creator/profile";

  // business profile
  static String createBusiness() => '$base/business/create';
  static String updateBusiness() => '$base/business/update';

  // core
  // categories
  static String getCategories() => '$base/category/get-all';

  // Other
  static String postFeedback() => '$base/feedback/post-feedback';

  static String getTermsConditions() {
    return '$base/manage/get-terms-conditions';
  }

  static String getPrivacyPolicy() {
    return '$base/manage/get-privacy-policy';
  }

  static String rateApp() {
    return '$base/user/rate-app';
  }

  static String getAboutUs() {
    return '$base/manage/get-about-us';
  }

  //Business

  static String myBusinesses({required int page, required int limit}) {
    return '$base/business/my?page=$page&limit=$limit';
  }

  // Create Offer (merchant)

  static String createOffer() {
    return '$base/offer/create';
  }

  static String getOffers() {
    return '$base/offer/get-all';
  }

  static String getMerchantOffers() {
    return '$base/offer/my';
  }

  static String getOfferDetails() {
    return '$base/offer/get';
  }

  static String updateOffer() {
    return '$base/offer/update';
  }

  // MEERCHANT

  static String merchantDashboard() {
    return "$base/merchant/dashboard";
  }

  // Campaign Merchant
  static String createMerchantCampaign() {
    return '$base/campaign/create';
  }

  static String merchantCampaigns() {
    return '$base/campaign/my';
  }

  static String merchantCampaignDetails() {
    return "$base/campaign/get";
  }

  static String campaignApplications() {
    return "$base/campaign/applications";
  }

  static String merchantCampaignAssignedInfluencerDetail() {
    return "$base/creator/merchant/get";
  }
}
