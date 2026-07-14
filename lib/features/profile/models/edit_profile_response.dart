class EditProfileModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;

  EditProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"],
      profileImage: json["profile_image"],
    );
  }
}
