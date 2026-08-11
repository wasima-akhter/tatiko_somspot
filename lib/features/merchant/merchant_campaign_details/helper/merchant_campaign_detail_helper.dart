import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

enum MerchantCampaignDetailsTab { overview, influencers, content, published }

extension MerchantCampaignDetailsTabExtension on MerchantCampaignDetailsTab {
  String get title {
    switch (this) {
      case MerchantCampaignDetailsTab.overview:
        return AppStrings.overview.tr;
      case MerchantCampaignDetailsTab.influencers:
        return AppStrings.influencers.tr;
      case MerchantCampaignDetailsTab.content:
        return AppStrings.content.tr;
      case MerchantCampaignDetailsTab.published:
        return AppStrings.published.tr;
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
