import '../../../../core/router/role_router.dart';
import '../../../../core/router/route_path.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/service/datasource/local/app_storage.dart';

class AppFlowRouter {
  AppFlowRouter._();

  static AppStorage get storage => AppStorage.to;

  static void afterLanguageSelected() {
    if (storage.isLoggedIn && storage.accessToken.isNotEmpty) {
      RoleRouter.navigateByRole();
      return;
    }

    if (storage.hasSeenOnboarding) {
      AppRouter.route.goNamed(RoutePath.loginScreen);
      return;
    }
    AppRouter.route.goNamed(RoutePath.chooseRoleScreen);
  }

  static void goToSignup() {
    if (storage.selectedRole == null) {
      AppRouter.route.goNamed(RoutePath.chooseRoleScreen);
      return;
    }

    AppRouter.route.goNamed(RoutePath.signUpScreen);
  }

  static void afterRoleSelected() {
    // If onboarding has already been completed,
    // this role selection came from the signup flow.
    if (storage.hasSeenOnboarding) {
      AppRouter.route.goNamed(RoutePath.signUpScreen);
      return;
    }

    // Otherwise this is the first-time onboarding flow.
    AppRouter.route.goNamed(RoutePath.onboardingScreen);
  }
}
