enum MerchantCampaignTab { all, pending, live }

enum MerchantCampaignStatus { draft, pendingReview, live }

extension MerchantCampaignStatusExtension on MerchantCampaignStatus {
  String get apiValue {
    switch (this) {
      case MerchantCampaignStatus.draft:
        return "draft";

      case MerchantCampaignStatus.pendingReview:
        return "pending_review";

      case MerchantCampaignStatus.live:
        return "live";
    }
  }

  String get displayName {
    switch (this) {
      case MerchantCampaignStatus.draft:
        return "DRAFT";

      case MerchantCampaignStatus.pendingReview:
        return "PENDING";

      case MerchantCampaignStatus.live:
        return "LIVE";
    }
  }

  static MerchantCampaignStatus fromApi(String value) {
    switch (value) {
      case "pending-review":
      case "pending_review":
      case "pending review":
        return MerchantCampaignStatus.pendingReview;

      case "live":
        return MerchantCampaignStatus.live;

      case "draft":
        return MerchantCampaignStatus.draft;

      default:
        return MerchantCampaignStatus.draft;
    }
  }
}
