import 'package:som_spot/helper/validator/text_field_validator.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../share/export/screen_export.dart';
import '../../auth/controller/auth_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(AppStrings.changePassword.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(24.h),

                // ── Form Fields Card ──
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: AppColors.backgroundsLinesColor.withValues(
                            alpha: 0.8,
                          ),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.02),
                            blurRadius: 10.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Current Password
                          CustomTextField(
                            controller: _currentPasswordController,
                            title: AppStrings.currentPassword.tr,
                            hintText: "**********",
                            isPassword: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 20.sp,
                              color: AppColors.hintTextColor,
                            ),
                            // validator: TextFieldValidator.password(),
                          ),
                          Gap(20.h),

                          // New Password
                          CustomTextField(
                            controller: _newPasswordController,
                            title: AppStrings.newPasswordLabel.tr,
                            hintText: "**********",
                            isPassword: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 20.sp,
                              color: AppColors.hintTextColor,
                            ),
                            // validator: TextFieldValidator.password(),
                          ),
                          Gap(20.h),

                          // Confirm Password
                          CustomTextField(
                            controller: _confirmPasswordController,
                            title: AppStrings.confirmPassword.tr,
                            hintText: "**********",
                            isPassword: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 20.sp,
                              color: AppColors.hintTextColor,
                            ),
                            validator: TextFieldValidator.confirmPassword(
                              _newPasswordController,
                            ),
                          ),
                          Gap(12.h),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(16.h),

                // ── Action Button ──
                Obx(
                  () => AuthController.to.isLoading.value
                      ? LoadingWidget()
                      : CustomButton(
                          text: AppStrings.saveChanges.tr,
                          onTap: () {
                            if (!(_formKey.currentState?.validate() ?? false)) {
                              return;
                            }

                            AuthController.to.changePassword(
                              oldPassword: _currentPasswordController.text
                                  .trim(),
                              newPassword: _newPasswordController.text.trim(),
                              confirmPassword: _confirmPasswordController.text
                                  .trim(),
                            );
                          },
                        ),
                ),
                Gap(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
