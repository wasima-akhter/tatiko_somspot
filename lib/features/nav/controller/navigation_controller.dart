import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/features/customer/customer_home/view/customer_home_screen.dart';
import 'package:som_spot/features/customer/saved/view/saved_screen.dart';
import 'package:som_spot/features/customer/search/view/search_screen.dart';
import 'package:som_spot/features/influencer_all/influencer_dashboard/view/influencer_dashboard_screen.dart';
import 'package:som_spot/features/influencer_all/influencer_task_screen/view/influencer_task_screen.dart';
import 'package:som_spot/features/merchant/dashboard_merchant/view/dashboard_merchant_screen.dart';
import 'package:som_spot/features/merchant/listings/view/listing_screen.dart';
import 'package:som_spot/features/merchant/stats/view/stats_screen.dart';
import 'package:som_spot/features/offers/view/offers_screen.dart';
import 'package:som_spot/features/profile/main_profile/view/profile_screen.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../utils/enum/app_enum.dart';
import '../../claims/view/claims_screen.dart';
import '../../influencer_all/influencer_wallet/view/influencer_wallet_screen.dart';

class NavigationControllerMain extends GetxController {
  static NavigationControllerMain get to => Get.find();
  RxInt selectedNavIndex = 0.obs;

  List<Widget> getPages() {
    switch (CommonController.to.role.value) {
      case UserRole.merchandiser:
        return const [
          DashboardMerchantScreen(),
          ListingScreen(),
          OffersScreen(),
          StatsScreen(),
          ProfileScreen(),
        ];
      case UserRole.influencer:
        return const [
          InfluencerDashboardScreen(),
          // InfluencerDiscoverScreen(),
          InfluencerTaskScreen(), // change the pages
          InfluencerWalletScreen(),
          ProfileScreen(),
        ];
      case UserRole.customer:
        return const [
          CustomerHomeScreen(),
          SearchScreen(),
          ClaimsScreen(),
          SavedScreen(),
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
          // Iconsax.discover,
          Iconsax.video,
          Iconsax.wallet,
          Iconsax.user,
        ];
      case UserRole.customer:
        return [
          Iconsax.home,
          Iconsax.search_normal,
          Iconsax.ticket,
          Iconsax.bookmark,
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
          AppStrings.dashboard,
          // AppStrings.discover, // change the names
          AppStrings.tasks,
          AppStrings.wallet,
          AppStrings.profile,
        ];
      case UserRole.customer:
        return [
          AppStrings.home,
          AppStrings.search,
          AppStrings.myClaims,
          AppStrings.saved,
          AppStrings.profile,
        ];
    }
  }

  // Tab index getters
  int get tabDashboard => 0;
  int get tabListing => 1;
  int get tabOffers => 2;
  int get tabStats => 3;
  int get tabProfile => 4;

  int get tabHome => 0;
  int get tabSearch => 1;
  int get tabSaved => 2;
  int get tabAlerts => 3;

  int get tabDiscover => 1;
  int get tabTasks => 2;
  int get tabWallet => 3;

  void changeTab(int index) {
    selectedNavIndex.value = index;
  }

  void goToTabDashboard() {
    changeTab(tabDashboard);
  }

  void goToTabListing() {
    changeTab(tabListing);
  }

  void goToTabOffers() {
    changeTab(tabOffers);
  }

  void goToTabStats() {
    changeTab(tabStats);
  }

  void goToTabProfile() {
    changeTab(tabProfile);
  }

  void goToTabHome() {
    changeTab(tabHome);
  }

  void goToTabSearch() {
    changeTab(tabSearch);
  }

  void goToTabSaved() {
    changeTab(tabSaved);
  }

  void goToTabAlerts() {
    changeTab(tabAlerts);
  }

  void goToTabDiscover() {
    changeTab(tabDiscover);
  }

  void goToTabTasks() {
    changeTab(tabTasks);
  }

  void goToTabWallet() {
    changeTab(tabWallet);
  }
}
