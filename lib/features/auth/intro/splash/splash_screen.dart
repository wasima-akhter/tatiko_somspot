import 'package:som_spot/core/custom_assets/assets.gen.dart';
import 'package:som_spot/core/service/datasource/local/app_storage.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../../../core/router/role_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 3));

    final storage = AppStorage.to;

    // Already logged in
    if (storage.isLoggedIn && storage.accessToken.isNotEmpty) {
      RoleRouter.navigateByRole();
      return;
    }

    // Language not selected
    if (!storage.hasSelectedLanguage) {
      AppRouter.route.goNamed(RoutePath.chooseLanguageScreen);

      return;
    }

    // Role not selected
    if (storage.role == null) {
      AppRouter.route.goNamed(RoutePath.chooseRoleScreen);

      return;
    }

    // Role selected but onboarding not completed

    if (!storage.hasSeenOnboarding) {
      AppRouter.route.goNamed(RoutePath.onboardingScreen);

      return;
    }

    // Default
    AppRouter.route.goNamed(RoutePath.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Assets.images.splashlogo.image(),

            const Gap(20),

            Text("Discover. Connect. Save.", style: context.headlineSmall),
          ],
        ),
      ),
    );
  }
}

/*

                 Splash
                    |
        --------------------------
        |                        |
   Logged in?                 No token
        |                        |
     Home              Language selected?
                              |
                    ----------------
                    |              |
                  No              Yes
                    |              |
              Language Screen   Role selected?
                                    |
                           ----------------
                           |              |
                         No              Yes
                           |              |
                      Choose Role    Onboarding done?
                                          |
                                   ---------------
                                   |             |
                                  No             Yes
                                   |              |
                            Onboarding       Login


*/
