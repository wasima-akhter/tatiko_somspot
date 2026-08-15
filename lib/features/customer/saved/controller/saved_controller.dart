import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../helper/saved_helper.dart';
import '../shared/response/saved_business_model.dart';
import '../shared/response/saved_offer_model.dart';
import '../shared/service/saved_service.dart';

class SavedScreenController extends GetxController {
  final SavedService _service;

  SavedScreenController(this._service);

  static SavedScreenController get to => Get.find();

  final listScrollController = ScrollController();

  late final Paginator<SavedBusinessModel> businessPaginator;
  late final Paginator<SavedOfferModel> offerPaginator;

  @override
  void onInit() {
    super.onInit();

    // -------------------------------

    businessPaginator = Paginator(
      fetchPage: (page, limit) async {
        final response = await _service.getSavedBusinesses(
          page: page,
          limit: limit,
        );

        return response.data!;
      },
    );

    offerPaginator = Paginator(
      fetchPage: (page, limit) async {
        final response = await _service.getSavedOffers(
          page: page,
          limit: limit,
        );

        return response.data!;
      },
    );

    listScrollController.addListener(() {
      if (!listScrollController.hasClients) return;

      if (listScrollController.position.pixels >=
          listScrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });

    loadBusinesses();
  }

  final rxSelectedTab = SavedTabType.businesses.obs;

  // ---------------------------------------------------------------------------
  // Tab
  // ---------------------------------------------------------------------------

  Future<void> selectTab(SavedTabType tab) async {
    if (rxSelectedTab.value == tab) return;

    rxSelectedTab.value = tab;

    if (tab == SavedTabType.businesses) {
      if (businessPaginator.items.isEmpty) {
        await loadBusinesses();
      }
    } else {
      if (offerPaginator.items.isEmpty) {
        await loadOffers();
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Businesses
  // ---------------------------------------------------------------------------

  Future<void> loadBusinesses() async {
    debugPrint('Before Businesses: ${businessPaginator.items.length}');

    await businessPaginator.loadInitial();

    debugPrint('After Businesses: ${businessPaginator.items.length}');
  }

  Future<void> refreshBusinesses() {
    return businessPaginator.refresh();
  }

  // ---------------------------------------------------------------------------
  // Offers
  // ---------------------------------------------------------------------------

  Future<void> loadOffers() async {
    debugPrint('Before Offers: ${offerPaginator.items.length}');

    await offerPaginator.loadInitial();

    debugPrint('After Offers: ${offerPaginator.items.length}');
  }

  Future<void> refreshOffers() {
    return offerPaginator.refresh();
  }

  // ---------------------------------------------------------------------------
  // Pagination
  // ---------------------------------------------------------------------------

  Future<void> loadMore() {
    if (rxSelectedTab.value == 0) {
      return businessPaginator.loadMore();
    }

    return offerPaginator.loadMore();
  }

  // ---------------------------------------------------------------------------
  // Claim
  // ---------------------------------------------------------------------------

  void toggleClaim(int index) {
    if (index < 0 || index >= offerPaginator.items.length) {
      return;
    }

    // offerPaginator.items[index].isClaimed.toggle();
  }

  // ---------------------------------------------------------------------------
  // Dispose
  // ---------------------------------------------------------------------------

  @override
  void onClose() {
    listScrollController.dispose();

    businessPaginator.dispose();
    offerPaginator.dispose();

    super.onClose();
  }
}

//
class SavedMockData {
  // ---------------------------------------------------------------------------
  // Mock Businesses
  // ---------------------------------------------------------------------------

  static final List<SavedBusinessModel> mockBusinesses = [
    SavedBusinessModel(
      id: 'sb_01',
      userId: 'user_123',
      business: SavedBusinessInfo(
        id: 'b_01',
        name: 'The Royal Bakery & Cafe',
        logo: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24',
        address: '123 Main Street, Downtown',
        ratingAvg: 4.8,
        ratingCount: 124,
      ),
    ),
    SavedBusinessModel(
      id: 'sb_02',
      userId: 'user_123',
      business: SavedBusinessInfo(
        id: 'b_02',
        name: 'Green Leaf Organic Grocers',
        logo: 'https://images.unsplash.com/photo-1542838132-92c53300491e',
        address: '456 Market Avenue, Westside',
        ratingAvg: 4.5,
        ratingCount: 89,
      ),
    ),
    SavedBusinessModel(
      id: 'sb_03',
      userId: 'user_123',
      business: SavedBusinessInfo(
        id: 'b_03',
        name: 'Urban Fitness Hub',
        logo: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48',
        address: '789 Fitness Boulevard, North Zone',
        ratingAvg: 4.9,
        ratingCount: 210,
      ),
    ),
  ];

  // ---------------------------------------------------------------------------
  // Mock Offers
  // ---------------------------------------------------------------------------

  static final List<SavedOfferModel> mockOffers = [
    SavedOfferModel(
      id: 'so_01',
      userId: 'user_123',
      offer: SavedOfferInfo(
        id: 'o_01',
        title: '50% Off on All Artisanal Pastries & Coffee',
        discountLabel: '50% OFF',
        offerImage:
            'https://images.unsplash.com/photo-1509440159596-0249088772ff',
        endAt: DateTime.now().add(const Duration(days: 2, hours: 5)),
        business: SavedOfferBusiness(
          id: 'b_01',
          name: 'The Royal Bakery & Cafe',
          logo: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24',
        ),
      ),
    ),
    SavedOfferModel(
      id: 'so_02',
      userId: 'user_123',
      offer: SavedOfferInfo(
        id: 'o_02',
        title: 'Buy 1 Month Membership, Get 2 Weeks Free',
        discountLabel: 'FREE 2 WEEKS',
        offerImage:
            'https://images.unsplash.com/photo-1517838277536-f5f99be501cd',
        endAt: DateTime.now().add(const Duration(hours: 12)),
        business: SavedOfferBusiness(
          id: 'b_03',
          name: 'Urban Fitness Hub',
          logo: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48',
        ),
      ),
    ),
    SavedOfferModel(
      id: 'so_03',
      userId: 'user_123',
      offer: SavedOfferInfo(
        id: 'o_03',
        title: 'Flat 20% Off on Organic Fresh Produce Basket',
        discountLabel: '20% OFF',
        offerImage:
            'https://images.unsplash.com/photo-1610348725531-843dff563e2c',
        endAt: DateTime.now().add(const Duration(days: 6)),
        business: SavedOfferBusiness(
          id: 'b_02',
          name: 'Green Leaf Organic Grocers',
          logo: 'https://images.unsplash.com/photo-1542838132-92c53300491e',
        ),
      ),
    ),
  ];
}
