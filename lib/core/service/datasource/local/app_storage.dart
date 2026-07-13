import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/enum/app_enum.dart';

class AppStorage extends GetxService {
  AppStorage();

  static AppStorage get to => Get.find<AppStorage>();

  final GetStorage _storage = GetStorage();

  // Keys
  static const String seenOnboardingKey = 'seen_onboarding';
  static const String isLoggedInKey = 'is_logged_in';
  static const String rememberMeKey = 'remember_me';

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  static const String authIdKey = 'auth_id';
  static const String userIdKey = 'user_id';
  static const String emailKey = 'email';

  static const String roleKey = 'role';

  static const String profileKey = 'profile';

  static const String languageKey = 'language';
  static const String themeKey = 'theme';

  static const String rememberedEmailKey = 'remembered_email';

  static const String pendingEmailKey = "pending_email";
  static const String pendingRoleKey = "pending_role";

  static const String tokenExpiryKey = 'token_expiry';

  // -----------------------
  // onboarding
  // -----------------------

  bool get hasSeenOnboarding => _storage.read(seenOnboardingKey) ?? false;

  Future<void> setSeenOnboarding(bool value) =>
      _storage.write(seenOnboardingKey, value);

  // -----------------------
  // login
  // -----------------------

  bool get isLoggedIn => _storage.read(isLoggedInKey) ?? false;

  Future<void> setLoggedIn(bool value) => _storage.write(isLoggedInKey, value);

  // -----------------------
  // remember me
  // -----------------------

  bool get rememberMe => _storage.read(rememberMeKey) ?? false;

  Future<void> setRememberMe(bool value) =>
      _storage.write(rememberMeKey, value);

  // -----------------------
  // access token
  // -----------------------

  String get accessToken => _storage.read(accessTokenKey) ?? "";

  Future<void> setAccessToken(String token) =>
      _storage.write(accessTokenKey, token);

  // -----------------------
  // refresh token
  // -----------------------

  String get refreshToken => _storage.read(refreshTokenKey) ?? "";

  Future<void> setRefreshToken(String token) =>
      _storage.write(refreshTokenKey, token);

  // -----------------------
  // role
  // -----------------------

  UserRole? get role {
    final value = _storage.read(roleKey);

    if (value == null) return null;

    return UserRole.values.firstWhereOrNull((e) => e.name == value);
  }

  Future<void> setRole(UserRole role) => _storage.write(roleKey, role.name);

  // -----------------------
  // pending role
  // -----------------------

  String get pendingEmail => _storage.read(pendingEmailKey) ?? "";

  Future<void> setPendingEmail(String email) =>
      _storage.write(pendingEmailKey, email);

  String get pendingRole => _storage.read(pendingRoleKey) ?? "";

  Future<void> setPendingRole(String role) =>
      _storage.write(pendingRoleKey, role);

  Future<void> clearPendingRegister() async {
    await _storage.remove(pendingEmailKey);
    await _storage.remove(pendingRoleKey);
  }

  // -----------------------
  // profile
  // -----------------------

  Map<String, dynamic>? get profile {
    final data = _storage.read(profileKey);

    if (data == null) return null;

    return Map<String, dynamic>.from(data);
  }

  // Future<void> setProfile(UserModel profile) =>
  //     _storage.write(profileKey, profile.toJson());

  // -----------------------
  // language
  // -----------------------

  // -----------------------
  // language
  // -----------------------

  String get languageCode => _storage.read(languageKey) ?? "";

  String get languageCountry => _storage.read("${languageKey}_country") ?? "";

  bool get hasSelectedLanguage => languageCode.isNotEmpty;

  Future<void> setLanguage({
    required String languageCode,
    String? countryCode,
  }) async {
    await _storage.write(languageKey, languageCode);

    if (countryCode != null) {
      await _storage.write("${languageKey}_country", countryCode);
    }
  }

  // -----------------------
  // theme
  // -----------------------

  String get theme => _storage.read(themeKey) ?? "system";

  Future<void> setTheme(String value) => _storage.write(themeKey, value);

  // -----------------------
  // remembered email
  // -----------------------

  String get rememberedEmail => _storage.read(rememberedEmailKey) ?? "";

  Future<void> setRememberedEmail(String value) =>
      _storage.write(rememberedEmailKey, value);

  // -----------------------
  // Save Session
  // -----------------------

  Future<void> saveSession({
    required String accessToken,
    String? refreshToken,
    String? authId,
    String? userId,
    String? email,
    UserRole? role,
  }) async {
    await setLoggedIn(true);

    await setAccessToken(accessToken);

    if (refreshToken != null && refreshToken.isNotEmpty) {
      await setRefreshToken(refreshToken);
    }

    if (authId != null && authId.isNotEmpty) {
      await setAuthId(authId);
    }

    if (userId != null && userId.isNotEmpty) {
      await setUserId(userId);
    }

    if (email != null && email.isNotEmpty) {
      await setEmail(email);
    }

    if (role != null) {
      await setRole(role);
    }
  }

  // -----------------------
  // user info from JWT
  // -----------------------

  String get authId => _storage.read(authIdKey) ?? "";

  Future<void> setAuthId(String value) => _storage.write(authIdKey, value);

  String get userId => _storage.read(userIdKey) ?? "";

  Future<void> setUserId(String value) => _storage.write(userIdKey, value);

  String get email => _storage.read(emailKey) ?? "";

  Future<void> setEmail(String value) => _storage.write(emailKey, value);

  int get tokenExpiry => _storage.read(tokenExpiryKey) ?? 0;

  Future<void> setTokenExpiry(int value) =>
      _storage.write(tokenExpiryKey, value);
  static const String refreshTokenExpiryKey = 'refresh_token_expiry';

  int get refreshTokenExpiry => _storage.read(refreshTokenExpiryKey) ?? 0;

  Future<void> setRefreshTokenExpiry(int value) =>
      _storage.write(refreshTokenExpiryKey, value);

  // -----------------------
  // logout
  // -----------------------

  Future<void> logout() async {
    await _storage.remove(accessTokenKey);
    await _storage.remove(refreshTokenKey);

    await _storage.remove(tokenExpiryKey);
    await _storage.remove(refreshTokenExpiryKey);

    await _storage.remove(authIdKey);
    await _storage.remove(userIdKey);
    await _storage.remove(emailKey);

    await _storage.remove(profileKey);
    await _storage.remove(roleKey);

    await _storage.remove(isLoggedInKey);

    // Keep:
    // onboarding
    // rememberMe
    // language
    // theme
    // rememberedEmail
  }
}
