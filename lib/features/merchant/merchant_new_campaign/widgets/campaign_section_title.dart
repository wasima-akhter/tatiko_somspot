import 'package:flutter/material.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class CampaignSectionTitle extends StatelessWidget {
  final String title;

  const CampaignSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: context.titleMedium);
  }
}
