import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../../share/language/controller/language_controller.dart';
import '../../../../share/export/screen_export.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../core/business/controller/business-controller.dart';
import '../../merchant_new_campaign/widgets/campaign_date_field.dart';
import '../controller/create_offer_controller.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  final CreateOfferController controller = CreateOfferController.to;
  final businessController = BusinessController.to;

  late final TextEditingController titleController;
  late final TextEditingController discountController;
  late final TextEditingController startDateController;
  late final TextEditingController endDateController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    controller.clearImage();

    titleController = TextEditingController();
    discountController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    descriptionController = TextEditingController();

    loadLanguages();
  }

  Future<void> loadLanguages() async {
    final languages = await LanguageController.getLanguages();

    print('Languages: $languages');

    languages.forEach((language, translations) {
      print('Language: $language');

      translations.forEach((key, value) {
        print('  $key: $value');
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    discountController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      title: AppStrings.createNewOffer.tr,

      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(),

              Gap(24.h),

              _buildLabel(AppStrings.offerTitle.tr),

              CustomTextField(
                controller: titleController,
                hintText: AppStrings.offerTitleHint.tr,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.offerTitleRequired.tr;
                  }

                  if (value.length < 3) {
                    return AppStrings.offerTitleTooShort.tr;
                  }

                  return null;
                },
              ),

              Gap(20.h),

              _buildLabel("${AppStrings.discount.tr} (%)"),

              CustomTextField(
                controller: discountController,
                hintText: AppStrings.offerDiscountHint.tr,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.offerDiscountRequired.tr;
                  }

                  final discount = int.tryParse(value);

                  if (discount == null) {
                    return AppStrings.offerDiscountInvalid.tr;
                  }

                  if (discount <= 0 || discount > 100) {
                    return AppStrings.offerDiscountRangeError.tr;
                  }

                  return null;
                },
              ),

              Gap(20.h),

              Row(
                children: [
                  Expanded(
                    child: CampaignDateField(
                      label: AppStrings.startDate.tr,
                      controller: startDateController,
                    ),
                  ),

                  Gap(16.w),

                  Expanded(
                    child: CampaignDateField(
                      label: AppStrings.endDate.tr,
                      controller: endDateController,
                    ),
                  ),
                ],
              ),

              Gap(20.h),

              _buildLabel(AppStrings.description.tr),

              CustomTextField(
                controller: descriptionController,
                hintText: AppStrings.offerDescriptionHint.tr,
                fillColor: AppColors.white,
                maxLines: 5,
                minLines: 2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.descriptionRequired.tr;
                  }

                  if (value.length < 10) {
                    return AppStrings.descriptionMinLength.tr;
                  }

                  return null;
                },
              ),

              Gap(24.h),

              Obx(
                () => CustomButton(
                  text: AppStrings.createOffer.tr,

                  isLoading:
                      controller.submitLoading.value == ApiStatus.loading ||
                      BusinessController
                              .to
                              .myBusinessesPaginator
                              .status
                              .value ==
                          ApiStatus.loading,

                  onTap: controller.submitLoading.value == ApiStatus.loading
                      ? null
                      : _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    controller.createOffer(
      title: titleController.text,
      discount: discountController.text,
      description: descriptionController.text,
      startDate: startDateController.text,
      endDate: endDateController.text,
    );
  }

  Widget _buildImagePicker() {
    // Cover Image Picker
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        controller.pickImage();
      },
      child: Obx(() {
        return Container(
          width: double.infinity,
          height: 140.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.backgroundsLinesColor),
            image: controller.imagePath.value.isNotEmpty
                ? DecorationImage(
                    image: FileImage(File(controller.imagePath.value)),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: controller.imagePath.value.isNotEmpty
              ? const SizedBox()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: AppColors.blueAccentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Iconsax.image,
                        color: AppColors.blueAccentColor,
                        size: 24.sp,
                      ),
                    ),
                    Gap(12.h),
                    Text(
                      AppStrings.tapToAddCoverImage.tr,
                      style: context.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      AppStrings.recommendedSizeOffer.tr,
                      style: context.bodySmall.copyWith(
                        color: AppColors.subtitleTextColor,
                      ),
                    ),
                  ],
                ),
        );
      }),
    );
  }

  Widget _dateField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),

        CustomTextField(
          controller: controller,
          readOnly: true,
          hintText: "Jul 15, 2025",
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.tryParse(controller.text) ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (date != null) {
              controller.text = DateFormat("MMM d, yyyy").format(date);
            }
          },
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Column(
      children: [
        Text(
          text,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        Gap(8.h),
      ],
    );
  }
}
