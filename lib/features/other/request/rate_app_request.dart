class RateAppRequest {
  final int rating;

  RateAppRequest({required this.rating});

  Map<String, dynamic> toJson() {
    return {"rating": rating};
  }
}
