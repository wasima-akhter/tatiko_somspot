class CurrentUserResponse {
  final String authId;
  final String userId;
  final String email;
  final String role;
  final bool isActive;
  final bool isProfileComplete;
  final List<String> missing;
  final UserSections sections;

  CurrentUserResponse({
    required this.authId,
    required this.userId,
    required this.email,
    required this.role,
    required this.isActive,
    required this.isProfileComplete,
    required this.missing,
    required this.sections,
  });

  factory CurrentUserResponse.fromJson(Map<String, dynamic> json) {
    return CurrentUserResponse(
      authId: json["authId"],
      userId: json["userId"],
      email: json["email"],
      role: json["role"],
      isActive: json["isActive"],
      isProfileComplete: json["isProfileComplete"],
      missing: List<String>.from(json["missing"] ?? []),
      sections: UserSections.fromJson(json["sections"] ?? {}),
    );
  }
}

class UserSections {
  final ProfileSection personal;
  final ProfileSection? business;
  final ProfileSection? creator;

  UserSections({required this.personal, this.business, this.creator});

  factory UserSections.fromJson(Map<String, dynamic> json) {
    return UserSections(
      personal: ProfileSection.fromJson(json["personal"] ?? {}),
      business: json["business"] != null
          ? ProfileSection.fromJson(json["business"])
          : null,
      creator: json["creator"] != null
          ? ProfileSection.fromJson(json["creator"])
          : null,
    );
  }
}

class ProfileSection {
  final bool complete;
  final List<String> missing;

  ProfileSection({required this.complete, required this.missing});

  factory ProfileSection.fromJson(Map<String, dynamic> json) {
    return ProfileSection(
      complete: json["complete"] ?? false,
      missing: List<String>.from(json["missing"] ?? []),
    );
  }
}
