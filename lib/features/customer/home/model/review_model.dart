class ReviewModel {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String dateAgo;
  final String content;
  int helpfulCount;
  bool isHelpful;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.dateAgo,
    required this.content,
    this.helpfulCount = 0,
    this.isHelpful = false,
  });
}
