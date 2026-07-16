class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String icon;
  final int order;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.order,
    required this.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["_id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      slug: json["slug"]?.toString() ?? "",
      icon: json["icon"]?.toString() ?? "",
      order: json["order"] ?? 0,
      isActive: json["isActive"] ?? false,
    );
  }
}
