import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../share/widgets/text_field/custom_text_field.dart';

class CampaignDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CampaignDateField({
    super.key,
    required this.label,
    required this.controller,
  });

  Future<void> _pickDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();

    if (controller.text.isNotEmpty) {
      initialDate = DateFormat("MMM d, yyyy").parse(controller.text);
    }

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      controller.text = DateFormat("MMM d, yyyy").format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: label,
      controller: controller,
      readOnly: true,
      hintText: AppStrings.offerDateHint.tr,
      suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
      onTap: () => _pickDate(context),
    );
  }
}
