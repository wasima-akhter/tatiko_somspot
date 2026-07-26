import 'package:som_spot/features/auth/complete_business_profile/controller/complete_business_profile_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';

class BusinessHoursStep extends StatelessWidget {
  const BusinessHoursStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CompleteBusinessProfileController.to;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(8.h),

          // ── Title ──
          Text(
            AppStrings.whenAreYouOpen.tr,
            style: context.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(8.h),

          // ── Subtitle ──
          Text(
            AppStrings.hoursSubtitle.tr,
            style: context.bodyLarge.copyWith(
              color: AppColors.subtitleTextColor,
              height: 1.5,
            ),
          ),
          Gap(20.h),

          // ── Days List ──
          Obx(() {
            final days = controller.businessHours.keys.toList();
            return Column(
              children: days.map((day) {
                final data = controller.businessHours[day]!;
                final isOpen = data['isOpen'] as bool;
                final openTime = data['openTime'] as TimeOfDay;
                final closeTime = data['closeTime'] as TimeOfDay;

                return _DayRow(
                  dayKey: day,
                  isOpen: isOpen,
                  openTime: openTime,
                  closeTime: closeTime,
                  onToggle: () => controller.toggleDayOpen(day),
                  onOpenTimeTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: openTime,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: AppColors.primaryColor,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      controller.updateOpenTime(day, picked);
                    }
                  },
                  onCloseTimeTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: closeTime,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: AppColors.primaryColor,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      controller.updateCloseTime(day, picked);
                    }
                  },
                  controller: controller,
                );
              }).toList(),
            );
          }),
          Gap(24.h),
        ],
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  final String dayKey;
  final bool isOpen;
  final TimeOfDay openTime;
  final TimeOfDay closeTime;
  final VoidCallback onToggle;
  final VoidCallback onOpenTimeTap;
  final VoidCallback onCloseTimeTap;
  final CompleteBusinessProfileController controller;

  const _DayRow({
    required this.dayKey,
    required this.isOpen,
    required this.openTime,
    required this.closeTime,
    required this.onToggle,
    required this.onOpenTimeTap,
    required this.onCloseTimeTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isOpen ? AppColors.white : AppColors.grayTabBgColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isOpen
              ? AppColors.primaryColor.withValues(alpha: 0.2)
              : AppColors.backgroundsLinesColor,
          width: 1,
        ),
        boxShadow: isOpen
            ? [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          // ── Day name + Toggle ──
          Row(
            children: [
              // Day icon
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: isOpen
                      ? AppColors.primaryColor.withValues(alpha: 0.1)
                      : AppColors.backgroundsLinesColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Iconsax.calendar_1,
                  size: 16.sp,
                  color: isOpen
                      ? AppColors.primaryColor
                      : AppColors.hintTextColor,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Text(
                  dayKey.tr,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isOpen
                        ? AppColors.darkTextColor
                        : AppColors.hintTextColor,
                  ),
                ),
              ),
              // Status text
              Text(
                isOpen ? AppStrings.openNow.tr : AppStrings.closed.tr,
                style: context.bodySmall.copyWith(
                  color: isOpen ? AppColors.success : AppColors.hintTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(8.w),
              // Toggle
              SizedBox(
                height: 24.h,
                child: Switch.adaptive(
                  value: isOpen,
                  onChanged: (_) => onToggle(),
                  activeTrackColor: AppColors.primaryColor.withValues(
                    alpha: 0.3,
                  ),
                  thumbColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.primaryColor;
                    }
                    return AppColors.hintTextColor;
                  }),
                  inactiveTrackColor: AppColors.backgroundsLinesColor,
                ),
              ),
            ],
          ),

          // ── Time Pickers (only when open) ──
          if (isOpen) ...[
            Gap(12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  // Open Time
                  Expanded(
                    child: _TimeChip(
                      label: controller.formatTime(openTime),
                      onTap: onOpenTimeTap,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 16.sp,
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                  // Close Time
                  Expanded(
                    child: _TimeChip(
                      label: controller.formatTime(closeTime),
                      onTap: onCloseTimeTap,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _TimeChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.backgroundsLinesColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.clock, size: 14.sp, color: AppColors.primaryColor),
            Gap(6.w),
            Text(
              label,
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
