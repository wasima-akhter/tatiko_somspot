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
