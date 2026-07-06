import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:som_spot/share/model/language_model.dart';
import 'package:som_spot/utils/config/app_config.dart';

class LanguageController extends GetxController implements GetxService {
  // ── UI State: Language Selection ──
  final selectedIndex =
      1.obs; // Default: English (index 1 in AppConfig.languages)

  List<LanguageModel> get languages => AppConfig.languages;

  LanguageModel get selectedLanguage => languages[selectedIndex.value];

  void selectLanguage(int index) {
    selectedIndex.value = index;
    applyLanguage(); // Instantly update locale
  }

  void applyLanguage() {
    final lang = selectedLanguage;
    Get.updateLocale(Locale(lang.languageCode, lang.countryCode));
  }

  // ── Translation Loader ──
  static Future<Map<String, Map<String, String>>> getLanguages() async {
    Map<String, Map<String, String>> languages = {};
    for (LanguageModel languageModel in AppConfig.languages) {
      String jsonStringValues = await rootBundle.loadString(
        'assets/languages/${languageModel.languageCode}.json',
      );
      Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
      Map<String, String> json = {};
      mappedJson.forEach((key, value) {
        json[key] = value.toString();
      });
      languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
          json;
    }
    return languages;
  }
}

class Messages extends Translations {
  final Map<String, Map<String, String>>? languages;
  Messages({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages!;
  }
}
