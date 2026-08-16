// somewhere shared, e.g. core/router/role_router.dart
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';

import '../../features/auth/completed_profile_customer_merchandiser/completed_profile_customer_args.dart';
import '../../features/auth/core/requests/auth_request.dart';
import '../../features/auth/core/service/auth_service.dart';
import '../../helper/snackbar/api_snackbar.dart';
import '../../utils/common_controller/common_controller.dart';
import '../di/repo_service_injection.dart';

class RoleRouter {
  static Future<void> navigateByRole() async {
    final service = sl<AuthService>();

    final response = await service.me();

    if (!response.success || response.data == null) {
      ApiSnackbar.show(response.message, type: SnackbarType.error);
      return;
    }

    final user = response.data!;

    //  // Save role globally
    // CommonController.to.setRole(UserRoleExtension.fromString(user.role));
    if (!CommonController.to.setRole(UserRoleExtension.fromString(user.role))) {
      return;
    }

    if (!user.isActive) {
      final resend = await service.resendOtp(
        ResendOtpRequest(email: user.email),
      );

      if (!resend.success) {
        ApiSnackbar.show(resend.message, type: SnackbarType.error);
        return;
      }

      AppRouter.route.goNamed(RoutePath.activeOtpScreen, extra: user.email);

      return;
    }

    // Personal profile not completed
    if (!user.isProfileComplete) {
      switch (user.role) {
        case "MERCHANT":
          AppRouter.route.goNamed(
            RoutePath.completedProfileCustomerScreen,
            extra: CompletedProfileCustomerArgs(
              email: user.email,
              role: user.role,
            ),
          );
          return;

        case "CREATOR":
          AppRouter.route.goNamed(RoutePath.completedProfileInfluencerScreen);
          return;

        case "USER":
          AppRouter.route.goNamed(
            RoutePath.completedProfileCustomerScreen,
            extra: CompletedProfileCustomerArgs(
              email: user.email,
              role: user.role,
            ),
          );
          return;

        default:
          ApiSnackbar.show(
            "Unknown role ${user.role}",
            type: SnackbarType.error,
          );
          return;
      }
    }

    // Personal profile completed.
    // Merchant may still need to complete business profile.
    // if (user.role == "MERCHANT" && user.missing.contains("business.business")) {
    //   AppRouter.route.goNamed(RoutePath.completeBusinessProfileScreen);
    //   return;
    // }

    // Business profile incomplete
    if (user.role == "MERCHANT" && !user.sections.business.complete) {
      AppRouter.route.goNamed(RoutePath.completeBusinessProfileScreen);
      return;
    }

    // Everything completed
    AppRouter.route.goNamed(RoutePath.navigationPages);
  }
}
