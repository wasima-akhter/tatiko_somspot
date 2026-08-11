import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/enum/app_enum.dart';
import '../response/customer_search_response.dart';
import '../service/customer_search_service.dart';

class SearchScreenController extends GetxController {
  final CustomerSearchService _service;

  SearchScreenController(this._service);

  static SearchScreenController get to => Get.find();

  // ---------------------------------------------------------------------------
  // Search
  // ---------------------------------------------------------------------------

  final searchController = TextEditingController();

  final searchStatus = ApiStatus.completed.obs;

  final searchErrorMessage = RxnString();

  final searchResults = <CustomerSearchResultModel>[].obs;

  final isSearchActive = false.obs;

  // ---------------------------------------------------------------------------
  // Recent Searches
  // ---------------------------------------------------------------------------

  final recentSearchStatus = ApiStatus.loading.obs;

  final recentSearchErrorMessage = RxnString();

  final recentSearches = <RecentSearchModel>[].obs;

  // ---------------------------------------------------------------------------
  // Trending Searches
  // ---------------------------------------------------------------------------

  final trendingSearchStatus = ApiStatus.loading.obs;

  final trendingSearchErrorMessage = RxnString();

  final trendingSearches = <TrendingSearchModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    loadRecentSearches();
    loadTrendingSearches();
  }

  // ---------------------------------------------------------------------------
  // Search
  // ---------------------------------------------------------------------------

  Future<void> search(String term) async {
    final value = term.trim();

    if (value.isEmpty) {
      resetSearch();
      return;
    }

    searchController.text = value;
    isSearchActive.value = true;

    try {
      searchStatus.value = ApiStatus.loading;
      searchErrorMessage.value = null;
      searchResults.clear();

      final response = await _service.search(term: value);

      if (response.success && response.data != null) {
        searchResults.assignAll(response.data!.results);

        searchStatus.value = ApiStatus.completed;
      } else {
        searchStatus.value = ApiStatus.error;
        searchErrorMessage.value = response.message;
      }
    } catch (e) {
      searchStatus.value = ApiStatus.error;
      searchErrorMessage.value = e.toString();
    }
  }

  void resetSearch() {
    searchController.clear();

    isSearchActive.value = false;

    searchResults.clear();

    searchStatus.value = ApiStatus.completed;

    searchErrorMessage.value = null;
  }

  Future<void> searchRecent(RecentSearchModel item) async {
    await search(item.term);
  }

  Future<void> searchTrending(TrendingSearchModel item) async {
    await search(item.term);
  }
  // ---------------------------------------------------------------------------
  // Recent Searches
  // ---------------------------------------------------------------------------

  Future<void> loadRecentSearches() async {
    try {
      recentSearchStatus.value = ApiStatus.loading;
      recentSearchErrorMessage.value = null;

      final response = await _service.getRecentSearches();

      if (response.success && response.data != null) {
        recentSearches.assignAll(response.data!);

        recentSearchStatus.value = ApiStatus.completed;
      } else {
        recentSearchStatus.value = ApiStatus.error;
        recentSearchErrorMessage.value = response.message;
      }
    } catch (e) {
      recentSearchStatus.value = ApiStatus.error;
      recentSearchErrorMessage.value = e.toString();
    }
  }

  // ---------------------------------------------------------------------------
  // Clear Recent Searches
  // ---------------------------------------------------------------------------

  final clearRecentSearchStatus = ApiStatus.completed.obs;
  final clearRecentSearchErrorMessage = RxnString();

  Future<bool> clearRecentSearches() async {
    try {
      clearRecentSearchStatus.value = ApiStatus.loading;
      clearRecentSearchErrorMessage.value = null;

      final response = await _service.clearRecentSearches();

      if (response.success) {
        recentSearches.clear();
        clearRecentSearchStatus.value = ApiStatus.completed;

        return true;
      }

      clearRecentSearchStatus.value = ApiStatus.error;
      clearRecentSearchErrorMessage.value = response.message;

      return false;
    } catch (e) {
      clearRecentSearchStatus.value = ApiStatus.error;
      clearRecentSearchErrorMessage.value = e.toString();

      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // Trending Searches
  // ---------------------------------------------------------------------------

  Future<void> loadTrendingSearches() async {
    try {
      trendingSearchStatus.value = ApiStatus.loading;
      trendingSearchErrorMessage.value = null;

      final response = await _service.getTrendingSearches();

      if (response.success && response.data != null) {
        trendingSearches.assignAll(response.data!);

        trendingSearchStatus.value = ApiStatus.completed;
      } else {
        trendingSearchStatus.value = ApiStatus.error;
        trendingSearchErrorMessage.value = response.message;
      }
    } catch (e) {
      trendingSearchStatus.value = ApiStatus.error;
      trendingSearchErrorMessage.value = e.toString();
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
