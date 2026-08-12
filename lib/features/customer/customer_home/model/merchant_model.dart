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

final List<MerchantModel> mockMerchants = [
  MerchantModel(
    id: '1',
    imageUrl: 'https://picsum.photos/200?random=1',
    title: 'Starbucks',
    category: 'Coffee & Tea',
    distance: '0.5 km',
    isOpen: true,
    rating: '4.5',
  ),
  MerchantModel(
    id: '2',
    imageUrl: 'https://picsum.photos/200?random=2',
    title: 'Pizza Hut',
    category: 'Pizza',
    distance: '1.2 km',
    isOpen: true,
    rating: '4.2',
  ),
  MerchantModel(
    id: '3',
    imageUrl: 'https://picsum.photos/200?random=3',
    title: 'Burger King',
    category: 'Fast Food',
    distance: '1.8 km',
    isOpen: false,
    rating: '4.0',
  ),
  MerchantModel(
    id: '4',
    imageUrl: 'https://picsum.photos/200?random=4',
    title: 'The Coffee Bean',
    category: 'Coffee & Tea',
    distance: '2.1 km',
    isOpen: true,
    rating: '4.6',
  ),
  MerchantModel(
    id: '5',
    imageUrl: 'https://picsum.photos/200?random=5',
    title: 'Kacchi Bhai',
    category: 'Bangladeshi',
    distance: '2.5 km',
    isOpen: true,
    rating: '4.7',
  ),
  MerchantModel(
    id: '6',
    imageUrl: 'https://picsum.photos/200?random=6',
    title: 'Chillox',
    category: 'Burgers',
    distance: '3.0 km',
    isOpen: false,
    rating: '4.4',
  ),
  MerchantModel(
    id: '7',
    imageUrl: 'https://picsum.photos/200?random=7',
    title: 'Takeout',
    category: 'Chinese',
    distance: '3.4 km',
    isOpen: true,
    rating: '4.3',
  ),
  MerchantModel(
    id: '8',
    imageUrl: 'https://picsum.photos/200?random=8',
    title: 'Sultan’s Dine',
    category: 'Bangladeshi',
    distance: '4.1 km',
    isOpen: true,
    rating: '4.8',
  ),
];
