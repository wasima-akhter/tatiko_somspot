import '../../../core/business/response/business-response.dart';

class MerchantAnalyticsResponse {
  final List<TopOfferModel> topOffers;
  final List<ClaimTrendModel> claimsTrend;

  MerchantAnalyticsResponse({
    required this.topOffers,
    required this.claimsTrend,
  });

  factory MerchantAnalyticsResponse.fromJson(Map<String, dynamic> json) {
    return MerchantAnalyticsResponse(
      topOffers: (json["topOffers"] as List? ?? [])
          .map((e) => TopOfferModel.fromJson(e))
          .toList(),
      claimsTrend: (json["claimsTrend"] as List? ?? [])
          .map((e) => ClaimTrendModel.fromJson(e))
          .toList(),
    );
  }
}

class TopOfferModel {
  final String id;
  final BusinessModel? business;

  final String title;
  final String discountLabel;
  final int totalClaims;

  TopOfferModel({
    required this.id,
    this.business,
    required this.title,
    required this.discountLabel,
    required this.totalClaims,
  });

  factory TopOfferModel.fromJson(Map<String, dynamic> json) {
    return TopOfferModel(
      id: json["_id"] ?? "",
      business: json["business"] != null
          ? BusinessModel.fromJson(json["business"])
          : null,
      title: json["title"] ?? "",
      discountLabel: json["discountLabel"] ?? "",
      totalClaims: json["totalClaims"] ?? 0,
    );
  }
}

/// Update when backend sends trend structure.
class ClaimTrendModel {
  final Map<String, dynamic> raw;

  ClaimTrendModel(this.raw);

  factory ClaimTrendModel.fromJson(Map<String, dynamic> json) {
    return ClaimTrendModel(json);
  }
}
