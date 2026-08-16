import 'package:som_spot/share/controller/language_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';

class LanguageDialogContent extends StatelessWidget {
  const LanguageDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = LanguageController.to;

    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(langController.languages.length, (index) {
          final lang = langController.languages[index];

          // Check selection using language code instead of index.
          final isSelected =
              langController.selectedLanguageCode == lang.languageCode;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              final language = langController.languageFromCode(
                lang.languageCode,
              );
              await langController.selectLanguage(language);
              if (context.mounted) Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.08)
                    : AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
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
                    width: 40.w,
                    height: 28.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundsLinesColor.withValues(
                        alpha: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      lang.imageUrl,
                      style: TextStyle(fontSize: 22.sp),
                    ),
                  ),

                  Gap(14.w),

                  // ── Language Name ──
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.languageName,
                          style: context.titleSmall.copyWith(
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.darkTextColor,
                          ),
                        ),
                        Gap(2.h),
                        Text(
                          _getNativeLanguageName(lang.languageCode),
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
                            width: 24.w,
                            height: 24.h,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: AppColors.white,
                              size: 16.sp,
                            ),
                          )
                        : Container(
                            key: const ValueKey('unselected'),
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.linesDarkColor,
                                width: 1.5.w,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  String _getNativeLanguageName(String languageCode) {
    switch (languageCode) {
      case 'so':
        return 'Somali';

      case 'ar':
        return 'العربية';

      case 'en':
      default:
        return 'English';
    }
  }
}
