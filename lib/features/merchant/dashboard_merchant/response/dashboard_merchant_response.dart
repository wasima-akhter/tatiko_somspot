class MerchantDashboardModel {
  final Merchant? merchant;
  final PrimaryBusiness? primaryBusiness;

  final int unreadNotifications;

  final CampaignStatus campaignStatus;

  final int businessCount;
  final int approved;
  final int pending;
  final int activeOffers;

  final int totalClaims;
  final int redeemedClaims;

  final int liveCampaigns;
  final int estRevenue;

  final int totalViews;

  final ActivitySummary activitySummary;

  final List<TopDeal> topDeals;
  final List<RecentClaim> recentClaims;

  MerchantDashboardModel({
    this.merchant,
    this.primaryBusiness,
    required this.unreadNotifications,
    required this.campaignStatus,
    required this.businessCount,
    required this.approved,
    required this.pending,
    required this.activeOffers,
    required this.totalClaims,
    required this.redeemedClaims,
    required this.liveCampaigns,
    required this.estRevenue,
    required this.totalViews,
    required this.activitySummary,
    required this.topDeals,
    required this.recentClaims,
  });

  factory MerchantDashboardModel.empty() {
    return MerchantDashboardModel(
      unreadNotifications: 0,
      campaignStatus: CampaignStatus.empty(),
      businessCount: 0,
      approved: 0,
      pending: 0,
      activeOffers: 0,
      totalClaims: 0,
      redeemedClaims: 0,
      liveCampaigns: 0,
      estRevenue: 0,
      totalViews: 0,
      activitySummary: ActivitySummary.empty(),
      topDeals: List.generate(3, (_) => TopDeal.empty()),
      recentClaims: List.generate(3, (_) => RecentClaim.empty()),
    );
  }

  factory MerchantDashboardModel.fromJson(Map<String, dynamic> json) {
    return MerchantDashboardModel(
      merchant: json['merchant'] != null
          ? Merchant.fromJson(json['merchant'])
          : null,

      primaryBusiness: json['primaryBusiness'] != null
          ? PrimaryBusiness.fromJson(json['primaryBusiness'])
          : null,

      unreadNotifications: json['unreadNotifications'] ?? 0,

      campaignStatus: CampaignStatus.fromJson(json['campaignStatus'] ?? {}),

      businessCount: json['businessCount'] ?? 0,
      approved: json['approved'] ?? 0,
      pending: json['pending'] ?? 0,
      activeOffers: json['activeOffers'] ?? 0,

      totalClaims: json['totalClaims'] ?? 0,
      redeemedClaims: json['redeemedClaims'] ?? 0,

      liveCampaigns: json['liveCampaigns'] ?? 0,
      estRevenue: json['estRevenue'] ?? 0,

      totalViews: json['totalViews'] ?? 0,

      activitySummary: ActivitySummary.fromJson(json['activitySummary'] ?? {}),

      topDeals: (json['topDeals'] as List? ?? [])
          .map((e) => TopDeal.fromJson(e))
          .toList(),

      recentClaims: (json['recentClaims'] as List? ?? [])
          .map((e) => RecentClaim.fromJson(e))
          .toList(),
    );
  }
}

class Merchant {
  final String name;
  final String profileImage;

  Merchant({required this.name, required this.profileImage});

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      name: json['name'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }
}

class PrimaryBusiness {
  final String name;
  final String address;

  PrimaryBusiness({required this.name, required this.address});

  factory PrimaryBusiness.fromJson(Map<String, dynamic> json) {
    return PrimaryBusiness(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

class CampaignStatus {
  final int inReview;
  final int active;

  CampaignStatus({
    required this.inReview,
    required this.active,
  });

  factory CampaignStatus.empty() {
    return CampaignStatus(
      inReview: 0,
      active: 0,
    );
  }

  factory CampaignStatus.fromJson(Map<String, dynamic> json) {
    return CampaignStatus(
      inReview: json['inReview'] ?? 0,
      active: json['active'] ?? 0,
    );
  }
}

class ActivitySummary {
  final int visitors;
  final int uniqueUsers;
  final int engagementRate;
  final int bounceRate;

  ActivitySummary({
    required this.visitors,
    required this.uniqueUsers,
    required this.engagementRate,
    required this.bounceRate,
  });

  factory ActivitySummary.empty() {
    return ActivitySummary(
      visitors: 0,
      uniqueUsers: 0,
      engagementRate: 0,
      bounceRate: 0,
    );
  }

  factory ActivitySummary.fromJson(Map<String, dynamic> json) {
    return ActivitySummary(
      visitors: json['visitors'] ?? 0,
      uniqueUsers: json['uniqueUsers'] ?? 0,
      engagementRate: json['engagementRate'] ?? 0,
      bounceRate: json['bounceRate'] ?? 0,
    );
  }
}

class TopDeal {
  final String title;
  final String discountLabel;
  final String businessName;
  final int totalClaims;

  TopDeal({
    required this.title,
    required this.discountLabel,
    required this.businessName,
    required this.totalClaims,
  });

  factory TopDeal.empty() {
    return TopDeal(
      title: '',
      discountLabel: '',
      businessName: '',
      totalClaims: 0,
    );
  }

  factory TopDeal.fromJson(Map<String, dynamic> json) {
    return TopDeal(
      title: json['title'] ?? '',
      discountLabel: json['discountLabel'] ?? '',
      businessName: json['businessName'] ?? '',
      totalClaims: json['totalClaims'] ?? 0,
    );
  }
}

class RecentClaim {
  final String title;
  final String? customerName;

  RecentClaim({required this.title, this.customerName});

  factory RecentClaim.empty() {
    return RecentClaim(title: '', customerName: null);
  }

  factory RecentClaim.fromJson(Map<String, dynamic> json) {
    return RecentClaim(
      title: json['title'] ?? '',
      customerName: json['customerName'],
    );
  }
}
