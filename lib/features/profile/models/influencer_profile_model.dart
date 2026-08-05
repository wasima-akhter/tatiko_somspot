class InfluencerProfileModel {
  final String id;

  final String user;

  final int followerCount;

  final String bio;

  final double engagementRate;

  final InfluencerCategory? category;

  final List<InfluencerSocialModel> socials;

  InfluencerProfileModel({
    required this.id,
    required this.user,
    required this.followerCount,
    required this.bio,
    required this.engagementRate,
    this.category,
    required this.socials,
  });

  factory InfluencerProfileModel.fromJson(Map<String, dynamic> json) {
    return InfluencerProfileModel(
      id: json["_id"] ?? "",

      user: json["user"] ?? "",

      followerCount: json["followerCount"] ?? 0,

      bio: json["bio"] ?? "",

      engagementRate: (json["engagementRate"] ?? 0).toDouble(),

      category: json["category"] == null
          ? null
          : InfluencerCategory.fromJson(json["category"]),

      socials: (json["socials"] as List<dynamic>? ?? [])
          .map((e) => InfluencerSocialModel.fromJson(e))
          .toList(),
    );
  }
}

class InfluencerCategory {
  final String id;

  final String name;

  final String slug;

  InfluencerCategory({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory InfluencerCategory.fromJson(Map<String, dynamic> json) {
    return InfluencerCategory(
      id: json["_id"] ?? "",

      name: json["name"] ?? "",

      slug: json["slug"] ?? "",
    );
  }
}

class InfluencerSocialModel {
  final String platform;

  final String handle;

  final String? url;

  final bool verified;

  InfluencerSocialModel({
    required this.platform,
    required this.handle,
    this.url,
    required this.verified,
  });

  factory InfluencerSocialModel.fromJson(Map<String, dynamic> json) {
    return InfluencerSocialModel(
      platform: json["platform"] ?? "",

      handle: json["handle"] ?? "",

      url: json["url"],

      verified: json["verified"] ?? false,
    );
  }
}
