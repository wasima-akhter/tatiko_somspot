import '../../../../core/router/role_router.dart';

class ProfileNavigationService {
  static Future<void> navigate() async {
    await RoleRouter.navigateByRole();
  }
}
