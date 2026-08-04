import '../../../../../share/model/pagination_meta_model.dart';

class InfluencerTasksResponse {
  final PaginationMeta meta;
  final TaskSummaryModel? summary;
  final List<InfluencerTaskModel> data;

  InfluencerTasksResponse({
    required this.meta,
    required this.data,
    this.summary,
  });
}

class InfluencerTaskModel {
  final String id;
  final CampaignModel? campaign;
  final String creator;
  final String status;
  final bool draftApproved;
  final int commissionAmount;
  final String stage;

  final DateTime? approvedAt;
  final DateTime? appliedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final int? version;

  final String? draftMediaType;
  final String? draftVideoUrl;
  final DateTime? submittedAt;

  // Additional API fields
  final String? caption;
  final String? platform;
  final String? thumbnail;

  InfluencerTaskModel({
    required this.id,
    this.campaign,
    required this.creator,
    required this.status,
    required this.draftApproved,
    required this.commissionAmount,
    required this.stage,

    this.approvedAt,
    this.appliedAt,
    this.createdAt,
    this.updatedAt,

    this.version,
    this.draftMediaType,
    this.draftVideoUrl,
    this.submittedAt,

    this.caption,
    this.platform,
    this.thumbnail,
  });

  factory InfluencerTaskModel.fromJson(Map<String, dynamic> json) {
    return InfluencerTaskModel(
      id: json["_id"] ?? json["id"] ?? "",

      campaign: json["campaign"] is Map<String, dynamic>
          ? CampaignModel.fromJson(json["campaign"])
          : null,

      creator: json["creator"]?.toString() ?? "",

      status: json["status"]?.toString() ?? "",

      draftApproved: json["draftApproved"] ?? false,

      commissionAmount: (json["commissionAmount"] as num?)?.toInt() ?? 0,

      stage: json["stage"]?.toString() ?? "",

      approvedAt: DateTime.tryParse(json["approvedAt"]?.toString() ?? ""),

      appliedAt: DateTime.tryParse(json["appliedAt"]?.toString() ?? ""),

      createdAt: DateTime.tryParse(json["createdAt"]?.toString() ?? ""),

      updatedAt: DateTime.tryParse(json["updatedAt"]?.toString() ?? ""),

      version: (json["__v"] as num?)?.toInt(),

      draftMediaType: json["draftMediaType"]?.toString(),

      draftVideoUrl: json["draftVideoUrl"]?.toString(),

      submittedAt: DateTime.tryParse(json["submittedAt"]?.toString() ?? ""),

      // New fields
      caption: json["caption"]?.toString(),

      platform: json["platform"]?.toString(),

      thumbnail: json["thumbnail"]?.toString(),
    );
  }
}

class TaskSummaryModel {
  final int active;
  final int pending;
  final int completed;
  final int published;

  TaskSummaryModel({
    required this.active,
    required this.pending,
    required this.completed,
    required this.published,
  });

  factory TaskSummaryModel.fromJson(Map<String, dynamic> json) {
    return TaskSummaryModel(
      active: json['active'] ?? 0,
      pending: json['pending'] ?? 0,
      completed: json['completed'] ?? 0,
      published: json['published'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'pending': pending,
      'completed': completed,
      'published': published,
    };
  }
}

class CampaignModel {
  final String id;
  final MerchantModel? merchant;
  final BusinessModel? business;
  final String offer;
  final String name;
  final String about;
  final String contentType;
  final DateTime endDate;
  final int videoLengthSec;
  final int pricePerClaim;

  CampaignModel({
    required this.id,
    this.merchant,
    this.business,
    required this.offer,
    required this.name,
    required this.about,
    required this.contentType,
    required this.endDate,
    required this.videoLengthSec,
    required this.pricePerClaim,
  });

  factory CampaignModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return CampaignModel(
        id: "",
        merchant: null,
        business: null,
        offer: "",
        name: "",
        about: "",
        contentType: "",
        endDate: DateTime.fromMillisecondsSinceEpoch(0),
        videoLengthSec: 0,
        pricePerClaim: 0,
      );
    }

    return CampaignModel(
      id: json["_id"]?.toString() ?? "",

      merchant: json["merchant"] is Map<String, dynamic>
          ? MerchantModel.fromJson(json["merchant"])
          : null,

      business: json["business"] is Map<String, dynamic>
          ? BusinessModel.fromJson(json["business"])
          : null,

      offer: json["offer"]?.toString() ?? "",

      name: json["name"]?.toString() ?? "",

      about: json["about"]?.toString() ?? "",

      contentType: json["contentType"]?.toString() ?? "",

      endDate: json["endDate"] != null
          ? DateTime.tryParse(json["endDate"].toString()) ??
                DateTime.fromMillisecondsSinceEpoch(0)
          : DateTime.fromMillisecondsSinceEpoch(0),

      videoLengthSec: (json["videoLengthSec"] as num?)?.toInt() ?? 0,

      pricePerClaim: (json["pricePerClaim"] as num?)?.toInt() ?? 0,
    );
  }
}

class MerchantModel {
  final String id;
  final String name;

  MerchantModel({required this.id, required this.name});

  factory MerchantModel.fromJson(Map<String, dynamic>? json) {
    return MerchantModel(
      id: json?["_id"]?.toString() ?? "",
      name: json?["name"]?.toString() ?? "",
    );
  }
}

class BusinessModel {
  final String id;
  final String name;
  final String? logo;

  BusinessModel({required this.id, required this.name, this.logo});

  factory BusinessModel.fromJson(Map<String, dynamic>? json) {
    return BusinessModel(
      id: json?["_id"]?.toString() ?? "",
      name: json?["name"]?.toString() ?? "",
      logo: json?["logo"]?.toString(),
    );
  }
}
