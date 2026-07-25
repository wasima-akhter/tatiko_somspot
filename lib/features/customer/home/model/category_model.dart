import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  /// Factory to parse from JSON (standard API pattern)
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: _getIconData(json['icon'] as String? ?? ''),
    );
  }

  /// Maps a dynamic string identifier from the API to its corresponding Flutter IconData
  static IconData _getIconData(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'restaurant':
      case 'restaurants':
        return Icons.restaurant_menu_outlined;
      case 'grocery':
      case 'groceries':
        return Icons.shopping_basket_outlined;
      case 'pharmacy':
      case 'pharmacies':
        return Icons.medication_outlined;
      case 'supermarket':
      case 'supermarkets':
        return Icons.storefront_outlined;
      case 'cafe':
      case 'cafes':
        return Icons.local_cafe_outlined;
      case 'electronic':
      case 'electronics':
        return Icons.devices_other_outlined;
      default:
        return Icons.category_outlined;
    }
  }
}
