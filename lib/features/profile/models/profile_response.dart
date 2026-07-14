class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;
  final String? address;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    this.address,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final auth = json["authId"];

    return ProfileModel(
      id: json["_id"] ?? "",

      // fallback to authId values if root values are missing
      name: json["name"] ?? auth?["name"] ?? "",

      email: json["email"] ?? auth?["email"] ?? "",

      phone: json["phone"],

      profileImage: json["profile_image"]?.toString().replaceAll("\\", "/"),

      address: json["address"],
    );
  }
}
