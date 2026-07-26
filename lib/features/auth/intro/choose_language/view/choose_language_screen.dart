import 'package:som_spot/share/controller/language_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';

class ChooseLanguageScreen extends StatelessWidget {
  ChooseLanguageScreen({super.key});

  // Fetch the globally injected controller (from initGetx)
  final _controller = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),

              // ── Page Title ──
              Text(
                AppStrings.chooseYourLanguage.tr,
                style: context.headlineMedium,
              ),
              const Gap(8),

              // ── Subtitle ──
              Text(
                AppStrings.pickLanguageSubtitle.tr,
                style: context.bodyLarge,
              ),
              const Gap(32),

              // ── Section Label ──
              Text(AppStrings.selectLanguage.tr, style: context.titleMedium),
              const Gap(16),

              // ── Language Cards ──
              Expanded(
                child: ListView.separated(
                  itemCount: _controller.languages.length,
                  separatorBuilder: (context, index) => const Gap(12),
                  itemBuilder: (context, index) {
                    final lang = _controller.languages[index];

                    return Obx(() {
                      final isSelected =
                          _controller.selectedIndex.value == index;

                      return _LanguageCard(
                        flag: lang.imageUrl,
                        name: lang.languageName,
                        nativeName: lang.countryCode == 'SO'
                            ? 'Somali'
                            : lang.countryCode == 'SA'
                            ? 'Arabic'
                            : 'English',
                        isSelected: isSelected,
                        onTap: () => _controller.selectLanguage(index),
                      );
                    });
                  },
                ),
              ),

              // ── Continue Button ──
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16),
                child: CustomButton(
                  text: AppStrings.continueText.tr,
                  onTap: () {
                    AppRouter.route.goNamed(RoutePath.chooseRoleScreen);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ── Individual Language Selection Card ──
/// Matches Figma: Rounded card with flag, name, native name, and check icon.
class _LanguageCard extends StatelessWidget {
  final String flag;
  final String name;
  final String nativeName;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.flag,
    required this.name,
    required this.nativeName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            // ── Flag ──
            Container(
              width: 40,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.backgroundsLinesColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(flag, style: const TextStyle(fontSize: 22)),
            ),
            const Gap(14),

            // ── Language Name + Native Name ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.titleSmall.copyWith(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.darkTextColor,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    nativeName,
                    style: context.bodySmall.copyWith(
                      color: AppColors.hintTextColor,
                    ),
                  ),
                ],
              ),
            ),

            // ── Selection Indicator ──
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? Container(
                      key: const ValueKey('selected'),
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
                      key: const ValueKey('unselected'),
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
