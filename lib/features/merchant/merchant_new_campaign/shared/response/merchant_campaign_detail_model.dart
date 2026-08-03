import '../../../../core/business/response/business-response.dart';
import '../../../../offers/shared/response/offers_response.dart';

class MerchantCampaignDetailsModel {
  final String id;

  final BusinessModel? business;
  final OfferModel? offer;

  final String name;
  final String about;
  final String objective;
  final String contentType;

  final String status;
  final String displayStatus;

  final int targetCreators;
  final int assignedCount;
  final int neededCreators;

  final double totalBudget;
  final double spentBudget;

  final int daysLeft;

  final List<MerchantCampaignTimelineStepModel> timeline;

  MerchantCampaignDetailsModel({
    required this.id,
    this.business,
    this.offer,
    required this.name,
    required this.about,
    required this.objective,
    required this.contentType,
    required this.status,
    required this.displayStatus,
    required this.targetCreators,
    required this.assignedCount,
    required this.neededCreators,
    required this.totalBudget,
    required this.spentBudget,
    required this.daysLeft,
    required this.timeline,
  });

  factory MerchantCampaignDetailsModel.fromJson(Map<String, dynamic> json) {
    return MerchantCampaignDetailsModel(
      id: json['_id'] ?? "",

      business: json['business'] != null
          ? BusinessModel.fromJson(json['business'])
          : null,

      offer: json['offer'] != null ? OfferModel.fromJson(json['offer']) : null,

      name: json['name'] ?? "",

      about: json['about'] ?? "",

      objective: json['objective'] ?? "",

      contentType: json['contentType'] ?? "",

      status: json['status'] ?? "",

      displayStatus: json['displayStatus'] ?? "",

      targetCreators: json['targetCreators'] ?? 0,

      assignedCount: json['assignedCount'] ?? 0,

      neededCreators: json['neededCreators'] ?? 0,

      totalBudget: (json['totalBudget'] ?? 0).toDouble(),

      spentBudget: (json['spentBudget'] ?? 0).toDouble(),

      daysLeft: json['daysLeft'] ?? 0,

      timeline: (json['timeline'] as List? ?? [])
          .map((e) => MerchantCampaignTimelineStepModel.fromJson(e))
          .toList(),
    );
  }
}

class MerchantCampaignTimelineStepModel {
  final String stage;
  final bool done;
  final bool current;

  MerchantCampaignTimelineStepModel({
    required this.stage,
    required this.done,
    required this.current,
  });

  factory MerchantCampaignTimelineStepModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return MerchantCampaignTimelineStepModel(
      stage: json['stage'] ?? "",
      done: json['done'] ?? false,
      current: json['current'] ?? false,
    );
  }
}

/// INFLUENCER List
class CampaignApplicationModel {
  final String id;
  final String status;
  final String? caption;
  final String? platform;

  final CampaignCreatorModel creator;

  CampaignApplicationModel({
    required this.id,
    required this.status,
    this.caption,
    this.platform,
    required this.creator,
  });

  factory CampaignApplicationModel.fromJson(Map<String, dynamic> json) {
    return CampaignApplicationModel(
      id: json["_id"] ?? "",
      status: json["status"] ?? "",
      caption: json["caption"],
      platform: json["platform"],

      creator: CampaignCreatorModel.fromJson(json["creator"] ?? {}),
    );
  }
}

class CampaignCreatorModel {
  final String id;
  final String name;
  final String profileImage;
  final BusinessCategory? category;

  CampaignCreatorModel({
    required this.id,
    required this.name,
    required this.profileImage,
    this.category,
  });

  factory CampaignCreatorModel.fromJson(Map<String, dynamic> json) {
    return CampaignCreatorModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      profileImage: json["profile_image"] ?? "",
      category: json["category"] == null
          ? null
          : BusinessCategory.fromJson(json["category"]),
    );
  }
}

// influencer info detail in bottom sheet
class MerchantCreatorModel {
  final String id;
  final String name;
  final String email;
  final String image;
  final int followerCount;
  final double engagementRate;
  final String category;
  final String bio;
  final int activeCount;
  final int pendingCount;
  final int doneCount;

  MerchantCreatorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.followerCount,
    required this.engagementRate,
    required this.category,
    required this.bio,
    required this.activeCount,
    required this.pendingCount,
    required this.doneCount,
  });

  factory MerchantCreatorModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return MerchantCreatorModel(
      id: json['_id'],
      name: user['name'] ?? "",
      email: user['email'] ?? "",
      image: user['profile_image'] ?? "",
      followerCount: json['followerCount'] ?? 0,
      engagementRate: (json['engagementRate'] ?? 0).toDouble(),
      category: json['category']?['name'] ?? "",
      bio: json['bio'] ?? "",
      activeCount: json['activeCount'] ?? 0,
      pendingCount: json['pendingCount'] ?? 0,
      doneCount: json['doneCount'] ?? 0,
    );
  }
}
