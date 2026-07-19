class FeedbackModel {
  final String id;
  final String user;
  final String name;
  final String email;
  final String subject;
  final String feedback;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  FeedbackModel({
    required this.id,
    required this.user,
    required this.name,
    required this.email,
    required this.subject,
    required this.feedback,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json["_id"] ?? "",
      user: json["user"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      subject: json["subject"] ?? "",
      feedback: json["feedback"] ?? "",
      status: json["status"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}
