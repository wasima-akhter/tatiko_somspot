import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../../../../core/custom_assets/assets.gen.dart';
import '../../../../../share/export/screen_export.dart';
import '../../../../../share/widgets/custom_text/custom_text.dart';
import '../controller/choose_role_controller.dart';

class ChooseRoleScreen extends GetView<ChooseRoleController> {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = CommonController.to.roles;

    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(28),

              // Logo / branding
              Center(child: Image.asset(Assets.images.splashlogo.path)),

              Gap(20.h),
              Expanded(
                child: Column(
                  children: [
                    CustomText(
                      text: AppStrings.whatBringsYouToSomSpot.tr,

                      fontSize: 18,
                      color: AppColors.blackMainTextColor,
                      fontWeight: FontWeight.w700,
                    ),

                    const Gap(8),

                    CustomText(
                      text: AppStrings.chooseTheExperienceThatIsRightForYou.tr,
                      fontSize: 15,
                      color: AppColors.grayTextSecondaryColor,
                    ),

                    const Gap(28),

                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: roles.length,
                        separatorBuilder: (_, _) => const Gap(14),
                        itemBuilder: (_, index) {
                          final role = roles[index];

                          return Obx(
                            () => _RoleCard(
                              title: controller.roleTitles[index].tr,
                              description:
                                  controller.roleDescriptions[index].tr,
                              icon: controller.roleIcons[index],
                              isSelected: controller.selectedRole.value == role,
                              onTap: () => controller.selectRole(role),
                            ),
                          );
                        },
                      ),
                    ),

                    const Gap(16),

                    Obx(
                      () => CustomButton(
                        text: AppStrings.continueText.tr,
                        isLoading: false,
                        onTap: controller.canContinue
                            ? controller.confirmAndContinue
                            : null,
                      ),
                    ),

                    const Gap(20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: .07)
              : AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.linesDarkColor,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                    color: AppColors.primaryColor.withValues(alpha: .08),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.backgroundColorNew,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.primaryColor,
                size: 25,
              ),
            ),

            const Gap(16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 16,

                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.darkTextColor,
                  ),

                  const Gap(5),

                  CustomText(
                    text: description,
                    fontSize: 14,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w400,

                    color: AppColors.grayTextSecondaryColor,
                  ),
                ],
              ),
            ),

            const Gap(12),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? const Icon(
                      Icons.check_circle_rounded,
                      key: ValueKey('selected'),
                      color: AppColors.primaryColor,
                    )
                  : Icon(
                      Icons.arrow_forward_ios_rounded,
                      key: const ValueKey('unselected'),
                      size: 16,
                      color: AppColors.linesDarkColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
