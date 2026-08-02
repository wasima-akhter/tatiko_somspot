class InfluencerInfoProfileRequest {
  final String category;
  final String bio;
  final int followerCount;
  final List<CreatorSocialRequest> socials;

  InfluencerInfoProfileRequest({
    required this.category,
    required this.bio,
    required this.followerCount,
    required this.socials,
  });
}

class CreatorSocialRequest {
  final String platform;
  final String handle;
  final String? url;

  CreatorSocialRequest({
    required this.platform,
    required this.handle,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      "platform": platform,
      "handle": handle,
      if (url != null && url!.isNotEmpty) "url": url,
    };
  }
}
