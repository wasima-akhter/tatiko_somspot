import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  // Search query
  final searchControllerText = ''.obs;

  // Recent Searches
  final rxRecentSearches = <String>[
    "Hilib Macaan",
    "Pharmacy near me",
    "Coffee shops",
    "Pizza",
  ].obs;

  // Trending items
  final rxTrendingItems = <String>[
    "Liido Beach Cafe",
    "Banadir Pharmacy",
    "Hayat Supermarket",
  ].obs;

  void clearRecentSearches() {
    rxRecentSearches.clear();
  }

  void removeRecentSearch(String item) {
    rxRecentSearches.remove(item);
  }

  void addRecentSearch(String item) {
    if (item.trim().isNotEmpty && !rxRecentSearches.contains(item.trim())) {
      rxRecentSearches.insert(0, item.trim());
    }
  }
}
