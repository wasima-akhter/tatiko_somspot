import 'package:flutter/services.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';

class CampaignNumberField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  final int min;
  final int max;

  const CampaignNumberField({
    super.key,

    required this.label,
    required this.hint,
    required this.controller,

    this.min = 1,
    this.max = 999,
  });

  @override
  State<CampaignNumberField> createState() => _CampaignNumberFieldState();
}

class _CampaignNumberFieldState extends State<CampaignNumberField> {
  int get currentValue {
    final value = int.tryParse(widget.controller.text);

    return value ?? widget.min;
  }

  void updateValue(int value) {
    final newValue = value.clamp(widget.min, widget.max);

    widget.controller.text = newValue.toString();

    widget.controller.selection = TextSelection.fromPosition(
      TextPosition(offset: widget.controller.text.length),
    );

    setState(() {});
  }

  void increase() {
    updateValue(currentValue + 1);
  }

  void decrease() {
    updateValue(currentValue - 1);
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: widget.label,

      controller: widget.controller,

      hintText: widget.hint,

      keyboardType: TextInputType.number,

      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

      suffix: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: decrease,
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Icon(
                  Iconsax.arrow_down_1,
                  color: AppColors.blueAccentColor,
                  size: 20.sp,
                ),
              ),
            ),
            Gap(6),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: currentValue >= widget.max ? null : increase,
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Icon(
                  Iconsax.arrow_up_2,
                  color: AppColors.blueAccentColor,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
