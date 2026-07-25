import 'package:flutter/material.dart';

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
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      controller.text =
          "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: label,

      controller: controller,

      readOnly: true,

      hintText: "DD/MM/YYYY",

      suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),

      onTap: () {
        _pickDate(context);
      },
    );
  }
}
