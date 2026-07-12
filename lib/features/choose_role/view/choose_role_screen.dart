import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../controller/choose_role_controller.dart';

class ChooseRoleScreen extends GetView<ChooseRoleController> {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              Text("Choose Your Role", style: context.headlineMedium),
              const Gap(8),
              Text(
                "Select the role you'd like to use across SomSpot. You can change it anytime.",
                style: context.bodyLarge,
              ),
              const Gap(32),

              Expanded(
                child: ListView.separated(
                  itemCount: controller.roles.length,
                  separatorBuilder: (_, _) => const Gap(12),
                  itemBuilder: (context, index) {
                    final role = controller.roles[index];

                    return Obx(() {
                      final isSelected = controller.selectedRole.value == role;

                      return _RoleCard(
                        title: controller.roleTitles[index],
                        isSelected: isSelected,
                        onTap: () => controller.selectRole(role),
                      );
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 32, top: 16),
                child: Obx(
                  () => CustomButton(
                    text: "Continue",
                    isLoading: false,
                    onTap: controller.canContinue
                        ? controller.confirmAndContinue
                        : null,
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

class _RoleCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.08)
              : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.linesDarkColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.titleSmall.copyWith(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.darkTextColor,
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? Container(
                      key: const ValueKey("selected"),
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 16,
                      ),
                    )
                  : Container(
                      key: const ValueKey("unselected"),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.linesDarkColor,
                          width: 1.5,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
