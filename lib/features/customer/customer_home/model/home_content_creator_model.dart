class CreatorContentModel {
  const CreatorContentModel({
    required this.id,
    required this.campaign,
    required this.creator,
    required this.platform,
    required this.draftVideoUrl,
    required this.thumbnail,
    required this.caption,
    required this.postUrl,
    required this.publishedAt,
  });

  final String id;
  final CreatorContentCampaignModel campaign;
  final CreatorContentCreatorModel creator;
  final String platform;
  final String draftVideoUrl;
  final String thumbnail;
  final String caption;
  final String postUrl;
  final DateTime? publishedAt;

  factory CreatorContentModel.fromJson(Map<String, dynamic> json) {
    return CreatorContentModel(
      id: json['_id']?.toString() ?? '',
      campaign: CreatorContentCampaignModel.fromJson(
        json['campaign'] as Map<String, dynamic>? ?? {},
      ),
      creator: CreatorContentCreatorModel.fromJson(
        json['creator'] as Map<String, dynamic>? ?? {},
      ),
      platform: json['platform']?.toString() ?? '',
      draftVideoUrl: json['draftVideoUrl']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
      caption: json['caption']?.toString() ?? '',
      postUrl: json['postUrl']?.toString() ?? '',
      publishedAt: DateTime.tryParse(json['publishedAt']?.toString() ?? ''),
    );
  }
}

class CreatorContentCampaignModel {
  const CreatorContentCampaignModel({
    required this.id,
    required this.business,
    required this.name,
  });

  final String id;
  final CreatorContentBusinessModel business;
  final String name;

  factory CreatorContentCampaignModel.fromJson(Map<String, dynamic> json) {
    return CreatorContentCampaignModel(
      id: json['_id']?.toString() ?? '',
      business: CreatorContentBusinessModel.fromJson(
        json['business'] as Map<String, dynamic>? ?? {},
      ),
      name: json['name']?.toString() ?? '',
    );
  }
}

class CreatorContentBusinessModel {
  const CreatorContentBusinessModel({
    required this.id,
    required this.name,
    required this.logo,
  });

  final String id;
  final String name;
  final String logo;

  factory CreatorContentBusinessModel.fromJson(Map<String, dynamic> json) {
    return CreatorContentBusinessModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      logo: json['logo']?.toString() ?? '',
    );
  }
}

class CreatorContentCreatorModel {
  const CreatorContentCreatorModel({
    required this.id,
    required this.name,
    required this.profileImage,
  });

  final String id;
  final String name;
  final String profileImage;

  factory CreatorContentCreatorModel.fromJson(Map<String, dynamic> json) {
    return CreatorContentCreatorModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      profileImage: json['profile_image']?.toString() ?? '',
    );
  }
}

final List<CreatorContentModel> mockCreatorContents = [
  CreatorContentModel(
    id: '6a7965d5f792519d4eada80c',
    campaign: CreatorContentCampaignModel(
      id: '6a7965d5f792519d4eada80b',
      name: 'Summer Food Campaign',
      business: CreatorContentBusinessModel(
        id: '6a7965d5f792519d4eada806',
        name: 'Hilib Macaan Restaurant',
        logo: 'https://cdn.somspot.so/businesses/hilib_logo.png',
      ),
    ),
    creator: CreatorContentCreatorModel(
      id: '6a7965d5f792519d4eada804',
      name: 'Ahmed Hassan',
      profileImage: 'https://randomuser.me/api/portraits/men/32.jpg',
    ),
    platform: 'tiktok',
    draftVideoUrl: 'https://cdn.somspot.so/videos/pizza_short.mp4',
    thumbnail: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
    caption: 'Best Pizza in Mogadishu! 🍕 Buy 1 Get 1 Free through SomSpot',
    postUrl: 'https://www.tiktok.com/@ahmedeats/video/7192837491',
    publishedAt: DateTime.parse('2026-08-10T05:47:01.450Z'),
  ),

  CreatorContentModel(
    id: '6a7965d5f792519d4eada81c',
    campaign: CreatorContentCampaignModel(
      id: '6a7965d5f792519d4eada81b',
      name: 'Weekend Coffee Campaign',
      business: CreatorContentBusinessModel(
        id: '6a7965d5f792519d4eada816',
        name: 'Mogadishu Coffee House',
        logo: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93',
      ),
    ),
    creator: CreatorContentCreatorModel(
      id: '6a7965d5f792519d4eada814',
      name: 'Fatima Mohamed',
      profileImage: 'https://randomuser.me/api/portraits/women/44.jpg',
    ),
    platform: 'instagram',
    draftVideoUrl: 'https://cdn.somspot.so/videos/coffee_reel.mp4',
    thumbnail: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085',
    caption: 'Best coffee spot in Mogadishu ☕️ Get 20% off through SomSpot!',
    postUrl: 'https://www.instagram.com/reel/example123',
    publishedAt: DateTime.parse('2026-08-09T10:30:00.000Z'),
  ),

  CreatorContentModel(
    id: '6a7965d5f792519d4eada82c',
    campaign: CreatorContentCampaignModel(
      id: '6a7965d5f792519d4eada82b',
      name: 'Fashion Week Campaign',
      business: CreatorContentBusinessModel(
        id: '6a7965d5f792519d4eada826',
        name: 'Sahal Fashion',
        logo: 'https://images.unsplash.com/photo-1445205170230-053b83016050',
      ),
    ),
    creator: CreatorContentCreatorModel(
      id: '6a7965d5f792519d4eada824',
      name: 'Sara Ahmed',
      profileImage: 'https://randomuser.me/api/portraits/women/68.jpg',
    ),
    platform: 'tiktok',
    draftVideoUrl: 'https://cdn.somspot.so/videos/fashion_reel.mp4',
    thumbnail: 'https://images.unsplash.com/photo-1483985988355-763728e1935b',
    caption: 'Summer fashion collection is here! 👗 Shop now with SomSpot.',
    postUrl: 'https://www.tiktok.com/@saraahmed/video/7192837522',
    publishedAt: DateTime.parse('2026-08-08T15:20:00.000Z'),
  ),

  CreatorContentModel(
    id: '6a7965d5f792519d4eada83c',
    campaign: CreatorContentCampaignModel(
      id: '6a7965d5f792519d4eada83b',
      name: 'Burger Festival',
      business: CreatorContentBusinessModel(
        id: '6a7965d5f792519d4eada836',
        name: 'Burger Point',
        logo: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add',
      ),
    ),
    creator: CreatorContentCreatorModel(
      id: '6a7965d5f792519d4eada834',
      name: 'Mohamed Ali',
      profileImage: 'https://randomuser.me/api/portraits/men/40.jpg',
    ),
    platform: 'youtube',
    draftVideoUrl: 'https://cdn.somspot.so/videos/burger_short.mp4',
    thumbnail: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
    caption: 'Have you tried this burger yet? 🍔 Buy 1 Get 1 Free!',
    postUrl: 'https://youtube.com/shorts/example456',
    publishedAt: DateTime.parse('2026-08-07T12:45:00.000Z'),
  ),
];
