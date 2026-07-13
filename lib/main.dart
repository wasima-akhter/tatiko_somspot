import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/di/getx_injection.dart';
import 'core/di/injection.dart';
import 'core/router/routes.dart';
import 'core/service/datasource/local/app_storage.dart';
import 'core/theme/light_theme.dart';
import 'helper/device_utils/device_utils.dart';
import 'share/controller/language_controller.dart';
import 'utils/app_keys/app_keys.dart';

void main() async {
  debugRepaintTextRainbowEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();

  await initAppStorage();

  await initDependencies();

  initGetx();

  final Map<String, Map<String, String>> languages =
      await LanguageController.getLanguages();

  runApp(
    //   MyApp(languages: languages),
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(languages: languages),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.languages});

  final Map<String, Map<String, String>>? languages;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design reference frame from Figma (iPhone 14 Pro = 393 × 852)
      designSize: const Size(393, 852),
      minTextAdapt: true,

      // IMPORTANT: Must be true so ScreenUtil reads MediaQuery from
      // DevicePreview (in debug) instead of the physical device.
      useInheritedMediaQuery: true,

      builder: (context, child) => GetMaterialApp.router(
        debugShowCheckedModeBanner: false,

        scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,

        // ── DevicePreview integration ──────────────────────────────────────
        // These two lines wire DevicePreview into the app in debug mode.
        // In release mode DevicePreview is disabled so they have no effect.
        useInheritedMediaQuery: true,
        builder: DevicePreview.appBuilder,
        // locale: DevicePreview.locale(context),
        locale: Locale(
          Get.find<LanguageController>().selectedLanguage.languageCode,
          Get.find<LanguageController>().selectedLanguage.countryCode,
        ),

        // ── Routing (go_router) ───────────────────────────────────────────
        routeInformationParser: AppRouter.route.routeInformationParser,
        routerDelegate: AppRouter.route.routerDelegate,
        routeInformationProvider: AppRouter.route.routeInformationProvider,

        // ── Theme ─────────────────────────────────────────────────────────
        themeMode: ThemeMode.light,
        theme: lightTheme,
        // darkTheme: darkTheme,  // Uncomment when dark theme is ready

        // ── Localisation ──────────────────────────────────────────────────
        translations: Messages(languages: languages),
        fallbackLocale: const Locale('en', 'US'),
      ),
    );
  }
}

Future<void> initAppStorage() async {
  await GetStorage.init();

  Get.put(AppStorage(), permanent: true);
}
