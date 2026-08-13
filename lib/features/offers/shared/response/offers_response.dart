class OfferModel {
  final String id;
  final BusinessOfferModel? business;
  final String title;
  final String description;
  final String discountLabel;
  final String terms;
  final DateTime startAt;
  final DateTime endAt;
  final String status;
  final int claimLimitPerUser;
  final int totalClaims;
  final int estimatedValue;
  final DateTime createdAt;

  final bool? isSaved;

  // Claim information
  bool isClaimed;
  final String? claimCode;
  final String? claimStatus;
  final String? claimId;

  OfferModel({
    required this.id,
    this.business,
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
    required this.createdAt,
    required this.isClaimed,
    this.claimCode,
    this.claimStatus,
    this.claimId,
    this.isSaved,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['_id'] ?? '',

      business: json['business'] != null
          ? BusinessOfferModel.fromJson(json['business'])
          : null,

      title: json['title'] ?? '',
      description: json['description'] ?? '',
      discountLabel: json['discountLabel'] ?? '',
      terms: json['terms'] ?? '',

      startAt: DateTime.tryParse(json['startAt'] ?? '') ?? DateTime.now(),

      endAt: DateTime.tryParse(json['endAt'] ?? '') ?? DateTime.now(),

      status: json['status'] ?? '',

      claimLimitPerUser: json['claimLimitPerUser'] ?? 0,
      totalClaims: json['totalClaims'] ?? 0,
      estimatedValue: json['estimatedValue'] ?? 0,

      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      isSaved: json['isSaved'] as bool? ?? false,

      // Claim information
      isClaimed: json['isClaimed'] as bool? ?? false,
      claimCode: json['claimCode'] as String?,
      claimStatus: json['claimStatus'] as String?,
      claimId: json['claimId'] as String?,
    );
  }
}

class BusinessOfferModel {
  final String id;
  final String? name;
  final String? logo;

  final String? category;
  final String? phone;
  final String? address;
  final double? ratingAvg;

  BusinessOfferModel({
    required this.id,
    this.name,
    this.logo,
    this.category,
    this.phone,
    this.address,
    this.ratingAvg,
  });

  factory BusinessOfferModel.fromJson(dynamic json) {
    // Case 1:
    // "business": "6a6704a26b2010bc2248ab14"
    if (json is String) {
      return BusinessOfferModel(id: json);
    }

    // Case 2:
    // "business": {...}
    if (json is Map<String, dynamic>) {
      return BusinessOfferModel(
        id: json['_id'] ?? '',

        name: json['name'],

        logo: json['logo'],

        category: json['category'],

        phone: json['phone'],

        address: json['address'],

        ratingAvg: json['ratingAvg'] != null
            ? (json['ratingAvg'] as num).toDouble()
            : null,
      );
    }

    return BusinessOfferModel(id: '');
  }
}
