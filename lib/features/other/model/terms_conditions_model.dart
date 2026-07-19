class TermsConditionsModel {
  final String id;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  TermsConditionsModel({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TermsConditionsModel.fromJson(Map<String, dynamic> json) {
    return TermsConditionsModel(
      id: json["_id"] ?? "",
      description: json["description"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}
