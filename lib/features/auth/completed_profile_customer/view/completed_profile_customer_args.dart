class CompletedProfileCustomerArgs {
  final String email;
  final String role;

  const CompletedProfileCustomerArgs({required this.email, required this.role});

  bool get isMerchant => role == "MERCHANT";
}
