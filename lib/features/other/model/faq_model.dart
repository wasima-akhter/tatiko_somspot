class FaqModel {
  final String id;
  final String question;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  FaqModel({
    required this.id,
    required this.question,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['_id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      description: json['description'] as String? ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
