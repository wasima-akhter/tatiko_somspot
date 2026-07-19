class MerchantDashboardModel {
  final int businessCount;
  final int approved;
  final int pending;
  final int activeOffers;
  final int totalClaims;
  final int redeemedClaims;
  final int liveCampaigns;
  final int estRevenue;

  MerchantDashboardModel({
    required this.businessCount,
    required this.approved,
    required this.pending,
    required this.activeOffers,
    required this.totalClaims,
    required this.redeemedClaims,
    required this.liveCampaigns,
    required this.estRevenue,
  });

  factory MerchantDashboardModel.empty() {
    return MerchantDashboardModel(
      businessCount: 0,
      approved: 0,
      pending: 0,
      activeOffers: 0,
      totalClaims: 0,
      redeemedClaims: 0,
      liveCampaigns: 0,
      estRevenue: 0,
    );
  }

  factory MerchantDashboardModel.fromJson(Map<String, dynamic> json) {
    return MerchantDashboardModel(
      businessCount: json['businessCount'] ?? 0,
      approved: json['approved'] ?? 0,
      pending: json['pending'] ?? 0,
      activeOffers: json['activeOffers'] ?? 0,
      totalClaims: json['totalClaims'] ?? 0,
      redeemedClaims: json['redeemedClaims'] ?? 0,
      liveCampaigns: json['liveCampaigns'] ?? 0,
      estRevenue: json['estRevenue'] ?? 0,
    );
  }
}
