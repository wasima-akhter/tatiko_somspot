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

//
enum CampaignContentType { videoAd, productReview, reel, story }

extension CampaignContentTypeExtension on CampaignContentType {
  String get apiValue {
    switch (this) {
      case CampaignContentType.videoAd:
        return 'video_ad';
      case CampaignContentType.productReview:
        return 'product_review';
      case CampaignContentType.reel:
        return 'reel';
      case CampaignContentType.story:
        return 'story';
    }
  }

  String get displayName {
    switch (this) {
      case CampaignContentType.videoAd:
        return 'Video Ad';
      case CampaignContentType.productReview:
        return 'Product Review';
      case CampaignContentType.reel:
        return 'Reel';
      case CampaignContentType.story:
        return 'Story';
    }
  }
}

//
enum CampaignObjective { awareness, traffic, offer, leadGeneration }

extension CampaignObjectiveExtension on CampaignObjective {
  String get apiValue {
    switch (this) {
      case CampaignObjective.awareness:
        return 'awareness';
      case CampaignObjective.traffic:
        return 'traffic';
      case CampaignObjective.offer:
        return 'offer';
      case CampaignObjective.leadGeneration:
        return 'lead_generation';
    }
  }

  String get displayName {
    switch (this) {
      case CampaignObjective.awareness:
        return 'Awareness';
      case CampaignObjective.traffic:
        return 'Traffic';
      case CampaignObjective.offer:
        return 'Offer';
      case CampaignObjective.leadGeneration:
        return 'Lead Generation';
    }
  }
}
