import 'dart:io';

import 'package:som_spot/helper/validator/text_field_validator.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../completed_profile_customer_args.dart';
import '../controller/completed_profile_customer_controller.dart';

class CompletedProfileCustomerScreen extends StatelessWidget {
  final CompletedProfileCustomerArgs args;

  const CompletedProfileCustomerScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final controller = CompletedProfileCustomerController.to;

    controller.initialize(email: args.email);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(24.h),

              Text(
                "Complete your Profile",
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),

              Gap(8.h),

              Text(
                "Help us personalize your SomSpot experience",
                style: context.bodyLarge.copyWith(
                  color: AppColors.subtitleTextColor,
                ),
              ),

              Gap(32.h),

              Center(
                child: Obx(() {
                  final imagePath = controller.profileImagePath.value;

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: controller.pickProfileImage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 120.w,
                      width: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: imagePath != null
                            ? null
                            : AppColors.primaryColor.withValues(alpha: 0.05),
                        border: Border.all(
                          color: AppColors.primaryColor.withValues(alpha: 0.4),
                          width: 2,
                        ),
                        image: imagePath != null
                            ? DecorationImage(
                                image: FileImage(File(imagePath)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: imagePath == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.gallery_add,
                                  size: 35.sp,
                                  color: AppColors.primaryColor,
                                ),
                                Gap(8.h),
                                Text(
                                  "Upload Photo",
                                  style: context.bodySmall.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Iconsax.camera,
                                  size: 16.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                    ),
                  );
                }),
              ),
              Gap(16.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Profile Photo",
                  textAlign: TextAlign.center,
                  style: context.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              Gap(40.h),

              // full name && email with title:
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.nameController,
                      title: AppStrings.fullName.tr,
                      hintText: AppStrings.ahmedMohamed.tr,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        size: 20,
                        color: AppColors.hintTextColor,
                      ),
                      validator: TextFieldValidator.name(),
                    ),
                    const Gap(16),
                    CustomTextField(
                      controller: controller.phoneController,
                      title: AppStrings.phoneNumber.tr,
                      hintText: "XXXXXXXXXXX",
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        size: 20,
                        color: AppColors.hintTextColor,
                      ),
                      validator: TextFieldValidator.phone(),
                    ),
                  ],
                ),
              ),
              const Gap(16),

              CustomTextField(
                readOnly: true,
                controller: controller.emailController,
                title: AppStrings.email.tr,
                hintText: AppStrings.exampleMail.tr,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  size: 20,
                  color: AppColors.hintTextColor,
                ),
              ),
              //
              Gap(40.h),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: args.isMerchant
                        ? "Finish & Setup"
                        : "Finish & Explore",
                    isLoading: controller.isLoading.value,
                    onTap: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      controller.finishSetup();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
