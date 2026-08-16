// ── Plan Data Model ──
import 'package:som_spot/share/export/screen_export.dart';

class SubscriptionPlanModel {
  final String name;
  final double price;
  final String priceSuffix;
  final int freeHotDeals;
  final int extraPostPrice;
  final List<String> features;
  final String highlightFeature;
  final bool isPopular;

  const SubscriptionPlanModel({
    required this.name,
    required this.price,
    required this.priceSuffix,
    required this.freeHotDeals,
    required this.extraPostPrice,
    required this.features,
    required this.highlightFeature,
    this.isPopular = false,
  });
}

class SubscriptionController extends GetxController {
  static SubscriptionController get to => Get.find();
  final selectedTabIndex = 0.obs;
  final selectedPlanIndex = 1.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
    selectedPlanIndex.value = 1; // Default to Growth
  }

  // ── Subscription Plans ──
  final List<SubscriptionPlanModel> subscriptionPlans = [
    SubscriptionPlanModel(
      name: 'Starter (Free)',
      price: 0.0,
      priceSuffix: ' /mo',
      freeHotDeals: 0,
      extraPostPrice: 5,
      features: [
        'Business profile listing',
        'Customer reviews',
        'Up to 5 photos',
        'Basic search visibility',
      ],
      highlightFeature: 'Free forever',
      isPopular: false,
    ),
    SubscriptionPlanModel(
      name: 'Growth',
      price: 9.99,
      priceSuffix: ' /mo',
      freeHotDeals: 5,
      extraPostPrice: 5,
      features: [
        'Verified badge',
        'Better search ranking',
        '25 photos/videos',
        'Basic analytics',
        'Promotional posts',
        '5 free Hot Deals / month',
      ],
      highlightFeature: '5 free Hot Deals included',
      isPopular: true,
    ),
    SubscriptionPlanModel(
      name: 'Premium',
      price: 29.99,
      priceSuffix: ' /mo',
      freeHotDeals: 10,
      extraPostPrice: 3,
      features: [
        'Top placement',
        'Featured listing',
        'Advanced analytics',
        'Unlimited media',
        'Multiple branches support',
        'Priority support',
        '10 free Hot Deals / month',
      ],
      highlightFeature: '10 free Hot Deals included',
      isPopular: false,
    ),
  ];

  // ── Influencer Boost Plans ──
  final List<SubscriptionPlanModel> influencerBoostPlans = [
    SubscriptionPlanModel(
      name: 'Basic',
      price: 49.0,
      priceSuffix: ' /campaign',
      freeHotDeals: 0,
      extraPostPrice: 0,
      features: [
        'Influencer visit to your business',
        'High-quality content creation',
        'Basic social media post',
      ],
      highlightFeature: 'Great for new businesses',
      isPopular: false,
    ),
    SubscriptionPlanModel(
      name: 'Growth',
      price: 99.0,
      priceSuffix: ' /campaign',
      freeHotDeals: 0,
      extraPostPrice: 0,
      features: [
        'Multiple posts across platforms',
        'Detailed business reviews',
        'Collaborative promotion',
        'Higher audience reach',
      ],
      highlightFeature: 'Most popular for growth',
      isPopular: true,
    ),
    SubscriptionPlanModel(
      name: 'Premium',
      price: 249.0,
      priceSuffix: '+ /campaign',
      freeHotDeals: 0,
      extraPostPrice: 0,
      features: [
        'Top influencers collaboration',
        'Professional video production',
        'Full campaign management',
        'Guaranteed engagement metrics',
      ],
      highlightFeature: 'Complete marketing suite',
      isPopular: false,
    ),
  ];

  List<SubscriptionPlanModel> get currentPlans =>
      selectedTabIndex.value == 0 ? subscriptionPlans : influencerBoostPlans;

  bool get isInfluencerTab => selectedTabIndex.value == 1;

  void selectPlan(int index) {
    selectedPlanIndex.value = index;
  }
}
