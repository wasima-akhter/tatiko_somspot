import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';

import '../../../../utils/common_controller/common_controller.dart';
import '../widgets/profile_statistics_section.dart';

class ProfileScreenController extends GetxController {
  static ProfileScreenController get to => Get.find();
  // User Profile details
  final userName = "Jorge Walton".obs;
  final userEmail = "example.mail.com".obs;
  final userPhone = "+252 61 5000000".obs;
  final userAvatar =
      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=150&auto=format&fit=crop"
          .obs;

  // Statistics
  final savedCount = 12.obs;
  final claimsCount = 8.obs;
  final reviewsCount = 5.obs;

  void logout() {
    AppToast.success(message: "You have successfully logged out.");
    AppRouter.route.goNamed(RoutePath.loginScreen);
  }

  List<ProfileStatModel> get profileStats {
    if (CommonController.to.isInfluencer) {
      return [
        ProfileStatModel(title: "Followers", value: "50K"),

        ProfileStatModel(title: "Engagement", value: "4.2%"),

        ProfileStatModel(title: "Campaigns", value: "12"),
      ];
    }

    if (CommonController.to.isCustomer) {
      return [
        ProfileStatModel(title: "Saved", value: "25"),

        ProfileStatModel(title: "Claims", value: "18"),

        ProfileStatModel(title: "Reviews", value: "12"),
      ];
    }

    if (CommonController.to.isMerchandiser) {
      return [];
    }

    return [];
  }
}
