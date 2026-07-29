import 'package:get/get.dart';

import '../../../../utils/app_strings/app_strings.dart';

enum OfferStatus { active, scheduled, expired }

extension OfferStatusApi on OfferStatus {
  String get value {
    switch (this) {
      case OfferStatus.active:
        return "active";
      case OfferStatus.scheduled:
        return "scheduled";
      // case OfferStatus.paused:
      //   return "paused";
      case OfferStatus.expired:
        return "expired";
    }
  }

  String get title {
    switch (this) {
      case OfferStatus.active:
        return AppStrings.active.tr;
      case OfferStatus.scheduled:
        return AppStrings.scheduled.tr;
      // case OfferStatus.paused:
      //   return AppStrings.paused.tr;
      case OfferStatus.expired:
        return AppStrings.expired.tr;
    }
  }
}

//

enum OfferActionType { claims, claimed, edit }

class OfferDisplayData {
  final String timeText;
  final bool isEndingSoon;
  final String actionText;
  final OfferActionType actionType;

  OfferDisplayData({
    required this.timeText,
    required this.isEndingSoon,
    required this.actionText,
    required this.actionType,
  });
}
