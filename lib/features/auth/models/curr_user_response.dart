// class CurrentUserResponse {
//   final bool success;
//   final String message;
//   final CurrentUserData? data;

//   CurrentUserResponse({
//     required this.success,
//     required this.message,
//     this.data,
//   });

//   factory CurrentUserResponse.fromJson(Map<String, dynamic> json) {
//     return CurrentUserResponse(
//       success: json["success"] ?? false,
//       message: json["message"] ?? "",
//       data: json["data"] == null
//           ? null
//           : CurrentUserData.fromJson(json["data"]),
//     );
//   }
// }

class CurrentUserResponse {
  final String authId;
  final String userId;
  final String email;
  final String role;
  final bool isActive;
  final bool isProfileComplete;
  final List<String> missing;

  CurrentUserResponse({
    required this.authId,
    required this.userId,
    required this.email,
    required this.role,
    required this.isActive,
    required this.isProfileComplete,
    required this.missing,
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
    );
  }
}
