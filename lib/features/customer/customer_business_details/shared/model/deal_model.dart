class DealModel {
  final String id;
  final OfferBusinessModel? business;
  final String title;
  final String description;
  final String discountLabel;
  final String terms;
  final String startAt;
  final String endAt;
  final String status;
  final int claimLimitPerUser;
  final int totalClaims;
  final num estimatedValue;
  final String createdBy;
  final String createdAt;
  final String updatedAt;

  // Claim information
  bool isClaimed;
  final String? claimCode;
  final String? claimStatus;
  final String? claimId;

  DealModel({
    required this.id,
    required this.business,
    required this.title,
    required this.description,
    required this.discountLabel,
    required this.terms,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.claimLimitPerUser,
    required this.totalClaims,
    required this.estimatedValue,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.isClaimed = false,
    this.claimCode,
    this.claimStatus,
    this.claimId,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['_id'] as String? ?? '',

      business: json['business'] is Map<String, dynamic>
          ? OfferBusinessModel.fromJson(
              json['business'] as Map<String, dynamic>,
            )
          : null,

      title: json['title'] as String? ?? '',

      description: json['description'] as String? ?? '',

      discountLabel: json['discountLabel'] as String? ?? '',

      terms: json['terms'] as String? ?? '',

      startAt: json['startAt'] as String? ?? '',

      endAt: json['endAt'] as String? ?? '',

      status: json['status'] as String? ?? '',

      claimLimitPerUser: (json['claimLimitPerUser'] as num?)?.toInt() ?? 0,

      totalClaims: (json['totalClaims'] as num?)?.toInt() ?? 0,

      estimatedValue: (json['estimatedValue'] as num?) ?? 0,

      createdBy: json['createdBy'] as String? ?? '',

      createdAt: json['createdAt'] as String? ?? '',

      updatedAt: json['updatedAt'] as String? ?? '',

      // Claim information
      isClaimed: json['isClaimed'] as bool? ?? false,
      claimCode: json['claimCode'] as String?,
      claimStatus: json['claimStatus'] as String?,
      claimId: json['claimId'] as String?,
    );
  }
}

class OfferBusinessModel {
  final String id;
  final String name;
  final String category;
  final String logo;
  final String address;
  final double ratingAvg;

  OfferBusinessModel({
    required this.id,
    required this.name,
    required this.category,
    required this.logo,
    required this.address,
    required this.ratingAvg,
  });

  factory OfferBusinessModel.fromJson(Map<String, dynamic> json) {
    return OfferBusinessModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      address: json['address'] as String? ?? '',
      ratingAvg: (json['ratingAvg'] as num?)?.toDouble() ?? 0,
    );
  }
}
