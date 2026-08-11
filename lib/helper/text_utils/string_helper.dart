import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return AppStrings.goodMorning.tr;
  } else if (hour >= 12 && hour < 17) {
    return AppStrings.goodAfternoon.tr;
  } else if (hour >= 17 && hour < 21) {
    return AppStrings.goodEvening.tr;
  } else {
    return AppStrings.goodNight.tr;
  }
}
