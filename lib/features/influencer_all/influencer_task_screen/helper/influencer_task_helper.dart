import 'package:get/get.dart';

import '../../../../utils/app_strings/app_strings.dart';

enum InfluencerTaskTab { active, pending, completed, published }

extension InfluencerTaskTabX on InfluencerTaskTab {
  String get apiValue {
    switch (this) {
      case InfluencerTaskTab.active:
        return 'active';

      case InfluencerTaskTab.pending:
        return 'pending';

      case InfluencerTaskTab.completed:
        return 'completed';

      case InfluencerTaskTab.published:
        return 'published';
    }
  }

  String get title {
    switch (this) {
      case InfluencerTaskTab.active:
        return AppStrings.active.tr;

      case InfluencerTaskTab.pending:
        return AppStrings.pending.tr;

      case InfluencerTaskTab.completed:
        return AppStrings.completed.tr;

      case InfluencerTaskTab.published:
        return AppStrings.published.tr;
    }
  }
}
