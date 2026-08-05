class InfluencerWalletResponse {
  final String period;
  final double earningsThisPeriod;
  final int claims;
  final List<EarningsTrendModel> earningsTrend;

  InfluencerWalletResponse({
    required this.period,
    required this.earningsThisPeriod,
    required this.claims,
    required this.earningsTrend,
  });

  factory InfluencerWalletResponse.fromJson(Map<String, dynamic> json) {
    return InfluencerWalletResponse(
      period: json["period"] ?? "",
      earningsThisPeriod: (json["earningsThisPeriod"] ?? 0).toDouble(),
      claims: json["claims"] ?? 0,
      earningsTrend: (json["earningsTrend"] as List? ?? [])
          .map((e) => EarningsTrendModel.fromJson(e))
          .toList(),
    );
  }

  factory InfluencerWalletResponse.empty() {
    return InfluencerWalletResponse(
      period: "",
      earningsThisPeriod: 0,
      claims: 0,
      earningsTrend: [],
    );
  }
}

class EarningsTrendModel {
  final String month;
  final String label;
  final double total;

  EarningsTrendModel({
    required this.month,
    required this.label,
    required this.total,
  });

  factory EarningsTrendModel.fromJson(Map<String, dynamic> json) {
    return EarningsTrendModel(
      month: json["month"] ?? "",
      label: json["label"] ?? "",
      total: (json["total"] ?? 0).toDouble(),
    );
  }
}
