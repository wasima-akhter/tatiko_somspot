class LanguageChangeResponse {
  final String id;
  final String name;
  final String language;

  LanguageChangeResponse({
    required this.id,
    required this.name,
    required this.language,
  });

  factory LanguageChangeResponse.fromJson(Map<String, dynamic> json) {
    return LanguageChangeResponse(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      language: json['language']?.toString() ?? '',
    );
  }
}
