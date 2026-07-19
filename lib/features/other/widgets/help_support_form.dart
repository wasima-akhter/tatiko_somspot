import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/helper/validator/text_field_validator.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../utils/enum/app_enum.dart';
import '../controller/other_controller.dart';

class HelpSupportForm extends StatelessWidget {
  const HelpSupportForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OtherController.to;

    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: controller.subjectController,
            fillColor: Colors.white,
            hintText: AppStrings.subject.tr,
            validator: TextFieldValidator.required(
              errorText: AppStrings.subjectRequired.tr,
            ),
          ),

          Gap(16.h),

          CustomTextField(
            controller: controller.messageController,
            fillColor: Colors.white,
            hintText: AppStrings.describeIssue.tr,
            maxLines: 4,
            minLines: 4,
            validator: TextFieldValidator.required(
              errorText: AppStrings.messageEmpty.tr,
            ),
          ),

          Gap(20.h),

          Obx(
            () => CustomButton(
              text: AppStrings.submitMessage.tr,
              isLoading: controller.submitLoading.value == ApiStatus.loading,
              onTap: controller.submitMessage,
            ),
          ),
        ],
      ),
    );
  }
}
