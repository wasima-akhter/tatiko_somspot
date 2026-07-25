class CreateOfferRequest {
  final String business;
  final String title;
  final String discountLabel;
  final String description;
  final String terms;
  final String startAt;
  final String endAt;

  CreateOfferRequest({
    required this.business,
    required this.title,
    required this.discountLabel,
    required this.description,
    required this.terms,
    required this.startAt,
    required this.endAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "business": business,
      "title": title,
      "discountLabel": discountLabel,
      "description": description,
      "terms": terms,
      "startAt": startAt,
      "endAt": endAt,
    };
  }
}
