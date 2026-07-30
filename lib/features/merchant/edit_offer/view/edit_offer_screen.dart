import 'dart:io';

import 'package:flutter/services.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../helper/date_converter/date_converter.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../offers/shared/response/offers_response.dart';
import '../../merchant_new_campaign/widgets/campaign_date_field.dart';
import '../controller/edit_offer_controller.dart';

class EditOfferScreen extends StatefulWidget {
  final OfferModel offer;

  const EditOfferScreen({super.key, required this.offer});

  @override
  State<EditOfferScreen> createState() => _EditOfferScreenState();
}

class _EditOfferScreenState extends State<EditOfferScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _discountController;
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;
  late final TextEditingController _descriptionController;

  final EditOfferController controller = EditOfferController.to;

  @override
  void initState() {
    super.initState();

    controller.clearImage();

    controller.selectBusinessId(widget.offer.business!.id);
    _titleController = TextEditingController(text: widget.offer.title);

    _discountController = TextEditingController(
      text: widget.offer.discountLabel.replaceAll("%", ""),
    );

    _startDateController = TextEditingController(
      text: DateConverter.formatDate(dateTime: widget.offer.startAt),
    );

    _endDateController = TextEditingController(
      text: DateConverter.formatDate(dateTime: widget.offer.endAt),
    );

    _descriptionController = TextEditingController(
      text: widget.offer.description,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();

    _discountController.dispose();

    _startDateController.dispose();

    _endDateController.dispose();

    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        elevation: 0,

        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () => context.pop(),

          icon: Icon(
            Icons.arrow_back_ios_new,

            size: 20.sp,

            color: AppColors.darkTextColor,
          ),
        ),

        title: Text(
          AppStrings.editOfferTitle.tr,

          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.bold,

            color: AppColors.darkTextColor,
          ),
        ),

        centerTitle: false,
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        padding: EdgeInsets.only(
          left: 20.w,

          right: 20.w,

          top: 16.h,

          bottom: 100.h,
        ),

        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              /// IMAGE
              GestureDetector(
                onTap: controller.pickImage,
                child: Obx(() {
                  final selectedImage = controller.imagePath.value;
                  final networkImage = widget.offer.business?.logo;

                  final hasLocalImage = selectedImage.isNotEmpty;
                  final hasNetworkImage =
                      networkImage != null && networkImage.isNotEmpty;

                  return Container(
                    width: double.infinity,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.backgroundsLinesColor,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (hasLocalImage)
                          Image.file(File(selectedImage), fit: BoxFit.cover)
                        else if (hasNetworkImage)
                          CustomNetworkImage(
                            imageUrl: networkImage,
                            fit: BoxFit.cover,
                          )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.blueAccentColor.withValues(
                                    alpha: 0.1,
                                  ),
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

                        if (hasLocalImage || hasNetworkImage)
                          Positioned(
                            top: 12.h,
                            right: 12.w,
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.55),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Iconsax.edit_2,
                                color: AppColors.white,
                                size: 18.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
              Gap(24.h),

              _buildLabel(AppStrings.offerTitle.tr),

              Gap(8.h),

              CustomTextField(
                controller: _titleController,

                hintText: 'e.g. 20% Off Family Platter',

                fillColor: AppColors.white,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Offer title is required";
                  }

                  if (value.length < 3) {
                    return "Title is too short";
                  }

                  return null;
                },
              ),

              Gap(20.h),

              _buildLabel(AppStrings.discount.tr),

              Gap(8.h),

              CustomTextField(
                controller: _discountController,

                hintText: '+e.g. 20% or BOGO',

                fillColor: AppColors.white,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Discount is required";
                  }

                  final discount = int.tryParse(value);

                  if (discount == null) {
                    return "Enter a valid discount";
                  }

                  if (discount <= 0 || discount > 100) {
                    return "Discount must be between 1 and 100";
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
                      controller: _startDateController,
                    ),
                  ),

                  Gap(16.w),

                  Expanded(
                    child: CampaignDateField(
                      label: AppStrings.endDate.tr,
                      controller: _endDateController,
                    ),
                  ),
                ],
              ),

              Gap(20.h),

              _buildLabel(AppStrings.description.tr),

              Gap(8.h),

              CustomTextField(
                controller: _descriptionController,

                fillColor: AppColors.white,

                maxLines: 5,

                minLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description is required";
                  }

                  if (value.length < 10) {
                    return "Description must be at least 10 characters";
                  }

                  return null;
                },
              ),

              Gap(20.h),

              Obx(
                () => CustomButton(
                  text: AppStrings.saveChanges.tr,
                  isLoading:
                      controller.submitLoading.value == ApiStatus.loading,
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
    controller.updateOffer(
      offerId: widget.offer.id,
      title: _titleController.text,
      discount: _discountController.text,
      description: _descriptionController.text,
      startDate: _startDateController.text,
      endDate: _endDateController.text,
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,

      style: context.titleMedium.copyWith(
        fontWeight: FontWeight.bold,

        color: AppColors.darkTextColor,
      ),
    );
  }
}
