import 'package:som_spot/share/model/language_model.dart';

class AppConfig {
  //API Base URL

  static const String baseURL = "https://nc5cnwcx-8000.inc1.devtunnels.ms";

  static const String fontFamily = "";

  //Default Language Key
  static const String defaultLanguageKey = "en";

  static const defaultProfile =
      "https://img.freepik.com/premium-photo/casual-young-man-shirt_146377-2992.jpg";

  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: "🇸🇴",
      languageName: 'Soomaali',
      countryCode: 'SO',
      languageCode: 'so',
    ),
    LanguageModel(
      imageUrl: "🇬🇧",
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      imageUrl: "🇸🇦",
      languageName: 'العربية',
      countryCode: 'SA',
      languageCode: 'ar',
    ),
  ];

  /*
  static final List<Map<String, dynamic>> factFastList = [
    {"icon": Icon(Iconsax.location), "title": AppStrings.location, "subTitle": "Los Angeles, CA – Griffith Park Fields"},
    {"icon": Icon(Iconsax.shop), "title": AppStrings.experience, "subTitle": "5 years"},
    {"icon": Icon(Iconsax.verify_otp), "title": AppStrings.certificate, "subTitle": "3", "eye": Icon(Iconsax.eye)},
  ];
*/
}
