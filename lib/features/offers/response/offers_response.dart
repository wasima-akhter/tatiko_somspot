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
      startAt: DateTime.parse(json['startAt']),
      endAt: DateTime.parse(json['endAt']),
      status: json['status'] ?? '',
      claimLimitPerUser: json['claimLimitPerUser'] ?? 0,
      totalClaims: json['totalClaims'] ?? 0,
      estimatedValue: json['estimatedValue'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class BusinessOfferModel {
  final String id;
  final String name;
  final String logo;
  final String address;
  final double ratingAvg;

  BusinessOfferModel({
    required this.id,
    required this.name,
    required this.logo,
    required this.address,
    required this.ratingAvg,
  });

  factory BusinessOfferModel.fromJson(Map<String, dynamic> json) {
    return BusinessOfferModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      address: json['address'] ?? '',
      ratingAvg: (json['ratingAvg'] ?? 0).toDouble(),
    );
  }
}
