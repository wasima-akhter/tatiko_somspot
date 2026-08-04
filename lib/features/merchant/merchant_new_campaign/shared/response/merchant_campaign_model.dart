import '../../../../core/business/response/business-response.dart';

class MerchantCampaignModel {
  final String id;
  final String name;
  final String? about;

  final String status;
  final String displayStatus;

  final BusinessModel? business;

  final int targetCreators;
  final int assignedCount;
  final int neededCreators;

  final double totalBudget;
  final double spentBudget;

  final int? daysLeft;

  final int videoLengthSec;

  final List<CampaignTimelineModel> timeline;

  MerchantCampaignModel({
    required this.id,
    required this.name,
    this.about,
    required this.status,
    required this.displayStatus,
    this.business,
    required this.targetCreators,
    required this.assignedCount,
    required this.neededCreators,
    required this.totalBudget,
    required this.spentBudget,
    this.daysLeft,
    required this.videoLengthSec,
    required this.timeline,
  });

  factory MerchantCampaignModel.fromJson(Map<String, dynamic> json) {
    return MerchantCampaignModel(
      id: json['_id'] ?? "",

      name: json['name'] ?? "",

      about: json['about'],

      status: json['status'] ?? "",

      displayStatus: json['displayStatus'] ?? "",

      business: json['business'] != null
          ? BusinessModel.fromJson(json['business'])
          : null,

      targetCreators: json['targetCreators'] ?? 0,

      assignedCount: json['assignedCount'] ?? 0,

      neededCreators: json['neededCreators'] ?? 0,

      totalBudget: (json['totalBudget'] ?? 0).toDouble(),

      spentBudget: (json['spentBudget'] ?? 0).toDouble(),

      daysLeft: json['daysLeft'],

      videoLengthSec: json['videoLengthSec'] ?? 0,

      timeline: (json['timeline'] as List? ?? [])
          .map((e) => CampaignTimelineModel.fromJson(e))
          .toList(),
    );
  }

  String get budgetText =>
      "\$${spentBudget.toStringAsFixed(0)} / \$${totalBudget.toStringAsFixed(0)}";

  String get applicants => assignedCount.toString();

  String get daysLeftText => daysLeft == null ? "" : "$daysLeft days left";
}

class CampaignTimelineModel {
  final String stage;
  final bool done;
  final bool current;

  CampaignTimelineModel({
    required this.stage,
    required this.done,
    required this.current,
  });

  factory CampaignTimelineModel.fromJson(Map<String, dynamic> json) {
    return CampaignTimelineModel(
      stage: json['stage'] ?? "",
      done: json['done'] ?? false,
      current: json['current'] ?? false,
    );
  }
}

//

//Merchant campaign Content list api model
class CampaignContentModel {
  final String id;

  final String? campaign;

  final CampaignContentCreator creator;

  final String status;

  final bool draftApproved;

  final int commissionAmount;

  final String draftMediaType;

  final String? draftVideoUrl;

  final String? caption;

  final String? platform;

  final String? thumbnail;

  final DateTime? approvedAt;

  final DateTime? appliedAt;

  final DateTime? submittedAt;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  CampaignContentModel({
    required this.id,
    this.campaign,
    required this.creator,
    required this.status,
    required this.draftApproved,
    required this.commissionAmount,
    required this.draftMediaType,
    this.draftVideoUrl,
    this.caption,
    this.platform,
    this.thumbnail,
    this.approvedAt,
    this.appliedAt,
    this.submittedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory CampaignContentModel.fromJson(Map<String, dynamic> json) {
    return CampaignContentModel(
      id: json["_id"]?.toString() ?? "",

      campaign: json["campaign"]?.toString(),

      creator: json["creator"] is Map<String, dynamic>
          ? CampaignContentCreator.fromJson(json["creator"])
          : CampaignContentCreator.empty(),

      status: json["status"]?.toString() ?? "",

      draftApproved: json["draftApproved"] ?? false,

      commissionAmount:
          int.tryParse(json["commissionAmount"]?.toString() ?? "0") ?? 0,

      draftMediaType: json["draftMediaType"]?.toString() ?? "video",

      draftVideoUrl: json["draftVideoUrl"]?.toString(),

      caption: json["caption"]?.toString(),

      platform: json["platform"]?.toString(),

      thumbnail: json["thumbnail"]?.toString(),

      approvedAt: _parseDate(json["approvedAt"]),

      appliedAt: _parseDate(json["appliedAt"]),

      submittedAt: _parseDate(json["submittedAt"]),

      createdAt: _parseDate(json["createdAt"]),

      updatedAt: _parseDate(json["updatedAt"]),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;

    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return null;
    }
  }
}

class CampaignContentCreator {
  final String id;

  final String name;

  final String profileImage;

  final String category;

  CampaignContentCreator({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.category,
  });

  factory CampaignContentCreator.fromJson(Map<String, dynamic> json) {
    return CampaignContentCreator(
      id: json["_id"]?.toString() ?? "",

      name: json["name"]?.toString() ?? "Unknown Creator",

      profileImage: json["profile_image"]?.toString() ?? "",

      category: json["category"] is Map
          ? json["category"]["name"]?.toString() ?? ""
          : "",
    );
  }

  factory CampaignContentCreator.empty() {
    return CampaignContentCreator(
      id: "",
      name: "Unknown Creator",
      profileImage: "",
      category: "",
    );
  }
}
