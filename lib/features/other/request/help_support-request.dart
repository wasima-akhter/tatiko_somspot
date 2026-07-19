class FeedbackRequest {
  final String subject;
  final String feedback;

  FeedbackRequest({required this.subject, required this.feedback});

  Map<String, dynamic> toJson() {
    return {"subject": subject, "feedback": feedback};
  }
}
