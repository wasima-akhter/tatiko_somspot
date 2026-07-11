import 'package:flutter/material.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class InfluencerMerchantName extends StatelessWidget {
  final String merchant;

  const InfluencerMerchantName({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return Text(
      merchant,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.bodyMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.grayTextSecondaryColor,
      ),
    );
  }
}
