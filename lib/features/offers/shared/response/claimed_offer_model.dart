class ClaimOfferModel {
  final String id;
  final String user;
  final String offer;
  final String business;
  final String code;
  final String status;
  final String claimedAt;
  final String expiresAt;

  ClaimOfferModel({
    required this.id,
    required this.user,
    required this.offer,
    required this.business,
    required this.code,
    required this.status,
    required this.claimedAt,
    required this.expiresAt,
  });

  factory ClaimOfferModel.fromJson(Map<String, dynamic> json) {
    return ClaimOfferModel(
      id: json['_id'] as String? ?? '',
      user: json['user'] as String? ?? '',
      offer: json['offer'] as String? ?? '',
      business: json['business'] as String? ?? '',
      code: json['code'] as String? ?? '',
      status: json['status'] as String? ?? '',
      claimedAt: json['claimedAt'] as String? ?? '',
      expiresAt: json['expiresAt'] as String? ?? '',
    );
  }
}
