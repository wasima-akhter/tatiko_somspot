class DealModel {
  final String id;
  final String imageUrl;
  final String title;
  final String merchantName;
  final String discount; // e.g. "20%" or "20% Off Family Platter"
  final String timeLeft; // e.g. "2 days"
  final String? videoUrl; // Optional video or overlay player url
  final bool isTopDeal;   // Helps segregate or classify top deals vs general banners

  DealModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.merchantName,
    required this.discount,
    required this.timeLeft,
    this.videoUrl,
    this.isTopDeal = false,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      id: json['id'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      title: json['title'] as String? ?? '',
      merchantName: json['merchantName'] as String? ?? '',
      discount: json['discount'] as String? ?? '',
      timeLeft: json['timeLeft'] as String? ?? '',
      videoUrl: json['videoUrl'] as String?,
      isTopDeal: json['isTopDeal'] as bool? ?? false,
    );
  }
}
