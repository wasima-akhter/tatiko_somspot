class InfluencerDashboardModel {
  final String name;
  final String profileImage;
  final String location;

  final int unreadNotifications;
  final double totalEarnings;
  final double pendingPayout;
  final int claims;

  final List<InfluencerActiveTaskModel> activeTasks;

  InfluencerDashboardModel({
    required this.name,
    required this.profileImage,
    required this.location,
    required this.unreadNotifications,
    required this.totalEarnings,
    required this.pendingPayout,
    required this.claims,
    required this.activeTasks,
  });

  factory InfluencerDashboardModel.fromJson(Map<String, dynamic> json) {
    return InfluencerDashboardModel(
      name: json["name"] ?? "",
      profileImage: json["profileImage"] ?? "",
      location: json["location"] ?? "",
      unreadNotifications: json["unreadNotifications"] ?? 0,
      totalEarnings: (json["totalEarnings"] ?? 0).toDouble(),
      pendingPayout: (json["pendingPayout"] ?? 0).toDouble(),
      claims: json["claims"] ?? 0,
      activeTasks: (json["activeTasks"] as List? ?? [])
          .map((e) => InfluencerActiveTaskModel.fromJson(e))
          .toList(),
    );
  }
}

class InfluencerActiveTaskModel {
  final String id;
  final String? businessName;
  final String campaignName;
  final String stage;
  final String statusLabel;
  final String? platform;
  final String? contentType;

  InfluencerActiveTaskModel({
    required this.id,
    this.businessName,
    required this.campaignName,
    required this.stage,
    required this.statusLabel,
    this.platform,
    this.contentType,
  });

  factory InfluencerActiveTaskModel.fromJson(Map<String, dynamic> json) {
    return InfluencerActiveTaskModel(
      id: json["_id"] ?? "",
      businessName: json["businessName"],
      campaignName: json["campaignName"] ?? "",
      stage: json["stage"] ?? "",
      statusLabel: json["statusLabel"] ?? "",
      platform: json["platform"],
      contentType: json["contentType"],
    );
  }
}
