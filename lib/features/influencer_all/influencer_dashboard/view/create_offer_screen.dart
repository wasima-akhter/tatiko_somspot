import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/features/offers/controller/offer_controller.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key});

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  late final TextEditingController _titleController;

  late final TextEditingController _discountController;

  late final TextEditingController _startDateController;

  late final TextEditingController _endDateController;

  late final TextEditingController _descriptionController;

  final OfferController controller = Get.put(OfferController());

  @override
  void initState() {
    super.initState();
    controller.clearImage();
    _titleController = TextEditingController(text: '');
    _discountController = TextEditingController(text: '');
    _startDateController = TextEditingController(text: '');
    _endDateController = TextEditingController(text: '');
    _descriptionController = TextEditingController(text: '');
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
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: AppColors.darkTextColor,
          ),
        ),
        title: Text(
          AppStrings.createNewOffer.tr,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children:[
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 16.h,
              bottom: 100.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image Picker
                GestureDetector(
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
                        border: Border.all(
                          color: AppColors.backgroundsLinesColor,
                        ),
                        image: controller.imagePath.value.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(
                                  File(controller.imagePath.value),
                                ),
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
                ),
                Gap(24.h),

                // Offer Title
                _buildLabel(AppStrings.offerTitle.tr),
                Gap(8.h),
                CustomTextField(
                  controller: _titleController,
                  hintText: 'e.g. 20% Off Family Platter',
                  fillColor: AppColors.white,
                ),
                Gap(20.h),

                // Discount
                _buildLabel(AppStrings.discount.tr),
                Gap(8.h),
                CustomTextField(
                  controller: _discountController,
                  hintText: '+e.g. 20% or BOGO',
                  fillColor: AppColors.white,
                ),
                Gap(20.h),

                // Dates
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel(AppStrings.startDate.tr),
                          Gap(8.h),
                          CustomTextField(
                            controller: _startDateController,
                            hintText: 'DD/MM/YYYY',
                            fillColor: AppColors.white,
                            readOnly: true,
                            onTap: () async {
                              DateTime? picked =  await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                _startDateController.text = '${picked.day}/${picked.month}/${picked.year}';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Gap(16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel(AppStrings.endDate.tr),
                          Gap(8.h),
                          CustomTextField(
                            controller: _endDateController,
                            hintText: 'DD/MM/YYYY',
                            fillColor: AppColors.white,
                            readOnly: true,
                            onTap: () async {
                              DateTime? picked =  await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null) {
                                _endDateController.text = '${picked.day}/${picked.month}/${picked.year}';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(20.h),

                // Description
                _buildLabel(AppStrings.description.tr),
                Gap(8.h),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: "What's included? Any restrictions?",
                  fillColor: AppColors.white,
                  maxLines: 5,
                  minLines: 5,
                ),
                Gap(20.h),
                CustomButton(
                  text: AppStrings.createOffer.tr,
                  onTap: () {
                    context.goNamed(RoutePath.subscriptionScreen);
                  },
                ),
              ],
            ),
          ),

          // Bottom sticky button
        ],
      ),
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
