enum CampaignStatus { inProgress, completed }

class CampaignModel {
  final String brand;
  final String title;
  final CampaignStatus status;

  const CampaignModel({
    required this.brand,
    required this.title,
    required this.status,
  });
}
