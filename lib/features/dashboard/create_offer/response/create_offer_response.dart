class OfferModel {
  final String id;
  final String business;
  final String title;
  final String description;
  final String discountLabel;
  final String terms;
  final String status;

  OfferModel({
    required this.id,
    required this.business,
    required this.title,
    required this.description,
    required this.discountLabel,
    required this.terms,
    required this.status,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json["_id"] ?? "",
      business: json["business"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      discountLabel: json["discountLabel"] ?? "",
      terms: json["terms"] ?? "",
      status: json["status"] ?? "",
    );
  }
}
