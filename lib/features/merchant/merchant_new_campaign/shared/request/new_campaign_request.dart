class CreateCampaignRequest {
  final String business;
  final String name;
  final String about;
  final String objective;
  final String contentType;
  final String influencerCategory;
  final int targetCreators;
  final int videoLengthSec;
  final String startDate;
  final String endDate;
  final String contentRequirements;
  final String offer;

  CreateCampaignRequest({
    required this.business,
    required this.name,
    required this.about,
    required this.objective,
    required this.contentType,
    required this.influencerCategory,
    required this.targetCreators,
    required this.videoLengthSec,
    required this.startDate,
    required this.endDate,
    required this.contentRequirements,
    required this.offer,
  });

  Map<String, dynamic> toJson() => {
    "business": business,
    "name": name,
    "about": about,
    "objective": objective,
    "contentType": contentType,
    "influencerCategory": influencerCategory,
    "targetCreators": targetCreators,
    "videoLengthSec": videoLengthSec,
    "startDate": startDate,
    "endDate": endDate,
    "contentRequirements": contentRequirements,
    "offer": offer,
  };
}
