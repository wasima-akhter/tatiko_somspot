class InfluencerTasksRequest {
  final int page;
  final int limit;
  final String stage;

  const InfluencerTasksRequest({
    this.page = 1,
    this.limit = 10,
    this.stage = "active",
  });

  Map<String, dynamic> toQuery() {
    return {"page": page, "limit": limit, "stage": stage};
  }
}
