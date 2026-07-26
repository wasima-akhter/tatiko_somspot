class MerchantModel {
  final String id;
  final String imageUrl;
  final String title;
  final String category;
  final String distance;
  final bool isOpen;
  final String rating;

  MerchantModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.distance,
    required this.isOpen,
    required this.rating,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
      id: json['id'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      distance: json['distance'] as String? ?? '',
      isOpen: json['isOpen'] as bool? ?? false,
      rating: json['rating'] as String? ?? '0.0',
    );
  }
}
