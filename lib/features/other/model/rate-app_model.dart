class RateAppModel {
  final String id;
  final String user;
  final int rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  RateAppModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RateAppModel.fromJson(Map<String, dynamic> json) {
    return RateAppModel(
      id: json["_id"] ?? "",
      user: json["user"] ?? "",
      rating: json["rating"] ?? 0,
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}
