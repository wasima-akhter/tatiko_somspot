class ToggleSavedModel {
  final bool saved;
  final String type;
  final SavedDocumentModel doc;

  ToggleSavedModel({
    required this.saved,
    required this.type,
    required this.doc,
  });

  factory ToggleSavedModel.fromJson(Map<String, dynamic> json) {
    return ToggleSavedModel(
      saved: json['saved'] ?? false,
      type: json['type'] ?? '',
      doc: SavedDocumentModel.fromJson(json['doc'] ?? {}),
    );
  }
}

class SavedDocumentModel {
  final String id;
  final String user;
  final String? business;
  final String? offer;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SavedDocumentModel({
    required this.id,
    required this.user,
    this.business,
    this.offer,
    this.createdAt,
    this.updatedAt,
  });

  factory SavedDocumentModel.fromJson(Map<String, dynamic> json) {
    return SavedDocumentModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      business: json['business'],
      offer: json['offer'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }
}
