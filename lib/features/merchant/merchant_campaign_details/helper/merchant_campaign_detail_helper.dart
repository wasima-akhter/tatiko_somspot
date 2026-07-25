enum MerchantCampaignDetailsTab { overview, influencers, content }

extension MerchantCampaignDetailsTabExt on MerchantCampaignDetailsTab {
  String get title {
    switch (this) {
      case MerchantCampaignDetailsTab.overview:
        return "Overview";
      case MerchantCampaignDetailsTab.influencers:
        return "Influencers";
      case MerchantCampaignDetailsTab.content:
        return "Content";
    }
  }
}

enum TimelineStepStatus { completed, current, pending }

class MerchantCampaignTimelineStep {
  const MerchantCampaignTimelineStep({
    required this.title,
    required this.status,
  });

  final String title;
  final TimelineStepStatus status;

  bool get isCompleted => status == TimelineStepStatus.completed;

  bool get isCurrent => status == TimelineStepStatus.current;

  bool get isPending => status == TimelineStepStatus.pending;
}
