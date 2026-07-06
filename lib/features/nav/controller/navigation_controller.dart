import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/features/alerts/view/alerts_screen.dart';
import 'package:som_spot/features/dashboard/view/dashboard_screen.dart';
import 'package:som_spot/features/home/view/home_screen.dart';
import 'package:som_spot/features/listings/view/listing_screen.dart';
import 'package:som_spot/features/offers/view/offers_screen.dart';
import 'package:som_spot/features/profile/main_profile/view/profile_screen.dart';
import 'package:som_spot/features/saved/view/saved_screen.dart';
import 'package:som_spot/features/search/view/search_screen.dart';
import 'package:som_spot/features/stats/view/stats_screen.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../utils/enum/app_enum.dart';

class NavigationControllerMain extends GetxController {
  static NavigationControllerMain get to => Get.find();
  RxInt selectedNavIndex = 0.obs;

  List<Widget> getPages() {
    switch (CommonController.to.role.value) {
      case UserRole.merchandiser:
        return const [
          DashboardScreen(),
          ListingScreen(),
          OffersScreen(),
          StatsScreen(),
          ProfileScreen(),
        ];
      case UserRole.influencer:
        return const [
          HomeScreen(),
          SearchScreen(),
          SavedScreen(), // change the pages
          AlertsScreen(),
          ProfileScreen(),
        ];
      case UserRole.customer:
        return const [
          HomeScreen(),
          SearchScreen(),
          SavedScreen(),
          AlertsScreen(),
          ProfileScreen(),
        ];
    }
  }

  List<IconData> get icons {
    switch (CommonController.to.role.value) {
      case UserRole.merchandiser:
        return [
          Iconsax.element_3,
          Iconsax.shop,
          Iconsax.tag,
          Iconsax.chart,
          Iconsax.user,
        ];
      case UserRole.influencer:
        return [
          Iconsax.element_3,
          Iconsax.flash,
          Iconsax.wallet,
          Iconsax.notification,
          Iconsax.user,
        ];
      case UserRole.customer:
        return [
          Iconsax.home,
          Iconsax.search_normal,
          Iconsax.bookmark,
          Iconsax.notification,
          Iconsax.user,
        ];
    }
  }

  List<String> get labels {
    switch (CommonController.to.role.value) {
      case UserRole.merchandiser:
        return [
          AppStrings.dashboard,
          AppStrings.listings,
          AppStrings.offers,
          AppStrings.stats,
          AppStrings.profile,
        ];
      case UserRole.influencer:
        return [
          AppStrings.home,
          AppStrings.search, // change the names
          AppStrings.saved,
          AppStrings.alerts,
          AppStrings.profile,
        ];
      case UserRole.customer:
        return [
          AppStrings.home,
          AppStrings.search,
          AppStrings.saved,
          AppStrings.alerts,
          AppStrings.profile,
        ];
    }
  }
}
