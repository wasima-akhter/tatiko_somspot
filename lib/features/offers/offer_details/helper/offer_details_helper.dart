import 'package:flutter/material.dart';

import '../../../../utils/color/app_colors.dart';

class OfferDetailsHelper {
  static Color statusTextColor(String status) {
    switch (status) {
      case 'active':
        return AppColors.emeraldGreenColor;

      case 'scheduled':
        return AppColors.amberYellowColor;

      case 'expired':
        return AppColors.grayTertiaryTextColor;

      default:
        return AppColors.grayTabBgColor;
    }
  }
}
