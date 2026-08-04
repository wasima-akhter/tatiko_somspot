enum InfluencerTaskTab { active, pending, completed, published }

extension InfluencerTaskTabX on InfluencerTaskTab {
  String get title {
    switch (this) {
      case InfluencerTaskTab.active:
        return "Active";
      case InfluencerTaskTab.pending:
        return "Pending";
      case InfluencerTaskTab.completed:
        return "Completed";
      case InfluencerTaskTab.published:
        return "Published";
    }
  }
}
