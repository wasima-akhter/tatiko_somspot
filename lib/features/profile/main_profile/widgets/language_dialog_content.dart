import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/share/controller/language_controller.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class LanguageDialogContent extends StatelessWidget {
  const LanguageDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final langController = Get.find<LanguageController>();

    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(langController.languages.length, (index) {
          final lang = langController.languages[index];
          final isSelected = langController.selectedIndex.value == index;

          return GestureDetector(
            onTap: () {
              langController.selectLanguage(index);
              Navigator.pop(context);
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
                          lang.countryCode == 'SO'
                              ? 'Somali'
                              : lang.countryCode == 'SA'
                              ? 'Arabic'
                              : 'English',
                          style: context.bodySmall.copyWith(
                            color: AppColors.hintTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
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
}
