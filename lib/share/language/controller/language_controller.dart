import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:som_spot/share/model/language_model.dart';
import 'package:som_spot/utils/config/app_config.dart';

import '../../../core/service/datasource/local/app_storage.dart';
import '../../../helper/snackbar/api_snackbar.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../service/language_service.dart';

enum AppLanguage { somali, english, arabic }

class LanguageController extends GetxController implements GetxService {
  LanguageController(this._service);

  static LanguageController get to => Get.find();

  final LanguageService _service;

  // ─────────────────────────────────────────────
  // UI State
  // ─────────────────────────────────────────────

  final selectedLanguage = AppLanguage.english.obs;

  final storage = AppStorage.to;

  List<LanguageModel> get languages => AppConfig.languages;

  LanguageModel get selectedLanguageModel {
    return languages.firstWhere(
      (language) => language.languageCode == selectedLanguageCode,
    );
  }

  // ─────────────────────────────────────────────
  // Language Mapping
  // ─────────────────────────────────────────────

  String get selectedLanguageCode {
    switch (selectedLanguage.value) {
      case AppLanguage.somali:
        return 'so';

      case AppLanguage.english:
        return 'en';

      case AppLanguage.arabic:
        return 'ar';
    }
  }

  AppLanguage languageFromCode(String code) {
    switch (code) {
      case 'so':
        return AppLanguage.somali;

      case 'ar':
        return AppLanguage.arabic;

      case 'en':
      default:
        return AppLanguage.english;
    }
  }

  // ─────────────────────────────────────────────
  // Change Language
  // ─────────────────────────────────────────────
  final RxBool isChangingLanguage = false.obs;
  final Rxn<AppLanguage> changingLanguage = Rxn<AppLanguage>();

  Future<bool> selectLanguage(AppLanguage language) async {
    if (isChangingLanguage.value) return false;

    final languageModel = languages.firstWhere(
      (item) => item.languageCode == languageCode(language),
    );

    if (selectedLanguageCode == languageModel.languageCode) {
      return true;
    }

    final previousLanguage = selectedLanguage.value;

    // ─────────────────────────────────────────────
    // No token = local-only language selection
    // ─────────────────────────────────────────────
    if (!storage.isLoggedIn || storage.accessToken.isEmpty) {
      selectedLanguage.value = language;

      await storage.setLanguage(
        languageCode: languageModel.languageCode,
        countryCode: languageModel.countryCode,
      );

      Get.updateLocale(
        Locale(languageModel.languageCode, languageModel.countryCode),
      );

      update();

      return true;
    }

    // ─────────────────────────────────────────────
    // Authenticated = update backend first
    // ─────────────────────────────────────────────
    changingLanguage.value = language;
    isChangingLanguage.value = true;

    try {
      final result = await _service.changeLanguage(
        language: languageModel.languageCode,
      );

      if (!result.success) {
        ApiSnackbar.show(
          result.message,
          title: 'Language',
          type: SnackbarType.error,
        );

        return false;
      }

      selectedLanguage.value = language;

      await storage.setLanguage(
        languageCode: languageModel.languageCode,
        countryCode: languageModel.countryCode,
      );

      Get.updateLocale(
        Locale(languageModel.languageCode, languageModel.countryCode),
      );

      ApiSnackbar.show(
        result.message,
        title: 'Language',
        type: SnackbarType.success,
      );

      update();

      return true;
    } catch (e) {
      selectedLanguage.value = previousLanguage;

      ApiSnackbar.show(
        AppStrings.somethingWentWrong.tr,
        title: AppStrings.language.tr,
        type: SnackbarType.error,
      );

      return false;
    } finally {
      isChangingLanguage.value = false;
      changingLanguage.value = null;
    }
  }

  Future<bool> syncLanguageWithServer() async {
    final languageModel = selectedLanguageModel;

    try {
      final result = await _service.changeLanguage(
        language: languageModel.languageCode,
      );

      if (!result.success) {
        ApiSnackbar.show(result.message, type: SnackbarType.error);

        return false;
      }

      return true;
    } catch (e, s) {
      debugPrint('Sync Language Error: $e');
      debugPrintStack(stackTrace: s);

      return false;
    }
  }

  Future<void> applyServerLanguage(AppLanguage language) async {
    selectedLanguage.value = language;

    final languageModel = languages.firstWhere(
      (item) => item.languageCode == languageCode(language),
    );

    await storage.setLanguage(
      languageCode: languageModel.languageCode,
      countryCode: languageModel.countryCode,
    );

    Get.updateLocale(
      Locale(languageModel.languageCode, languageModel.countryCode),
    );

    update();
  }
  // ─────────────────────────────────────────────
  // Get Language Code
  // ─────────────────────────────────────────────

  String languageCode(AppLanguage language) {
    switch (language) {
      case AppLanguage.somali:
        return 'so';

      case AppLanguage.english:
        return 'en';

      case AppLanguage.arabic:
        return 'ar';
    }
  }

  // ─────────────────────────────────────────────
  // Apply Current Language
  // ─────────────────────────────────────────────

  void applyLanguage() {
    final languageModel = selectedLanguageModel;

    Get.updateLocale(
      Locale(languageModel.languageCode, languageModel.countryCode),
    );
  }

  // ─────────────────────────────────────────────
  // Translation Loader
  // ─────────────────────────────────────────────

  static Future<Map<String, Map<String, String>>> getLanguages() async {
    final Map<String, Map<String, String>> languages = {};

    for (final LanguageModel languageModel in AppConfig.languages) {
      final jsonStringValues = await rootBundle.loadString(
        'assets/languages/${languageModel.languageCode}.json',
      );

      final Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);

      final Map<String, String> json = {};

      mappedJson.forEach((key, value) {
        json[key] = value.toString();
      });

      languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
          json;
    }

    return languages;
  }
}

// ─────────────────────────────────────────────
// GetX Translations
// ─────────────────────────────────────────────

class Messages extends Translations {
  final Map<String, Map<String, String>> languages;

  Messages({required this.languages});

  @override
  Map<String, Map<String, String>> get keys => languages;
}
