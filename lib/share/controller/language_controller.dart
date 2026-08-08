import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:som_spot/share/model/language_model.dart';
import 'package:som_spot/utils/config/app_config.dart';

import '../../core/service/datasource/local/app_storage.dart';

enum AppLanguage { somali, english, arabic }

class LanguageController extends GetxController implements GetxService {
  // ─────────────────────────────────────────────
  // UI State
  // ─────────────────────────────────────────────

  // Default language: English
  final selectedLanguage = AppLanguage.english.obs;

  final storage = AppStorage.to;

  // Existing language list from AppConfig.
  List<LanguageModel> get languages => AppConfig.languages;

  // Currently selected LanguageModel.
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

  Future<void> selectLanguage(AppLanguage language) async {
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
