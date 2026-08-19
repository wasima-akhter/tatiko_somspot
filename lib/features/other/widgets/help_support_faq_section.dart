import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../controller/other_controller.dart';
import 'help_support_faq_item.dart';

class HelpSupportFaqSection extends StatelessWidget {
  const HelpSupportFaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OtherController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.faq.tr.toUpperCase(),
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.darkTextColor,
          ),
        ),

        SizedBox(height: 12.h),

        Obx(
          () => ApiStatusBuilder(
            status: controller.faqPaginator.status.value,
            errorMessage: controller.faqPaginator.errorMessage.value,
            onRetry: controller.loadFaq,
            isLoadingMore:
                controller.faqPaginator.loadMoreStatus.value ==
                ApiStatus.loading,
            hasMore: controller.faqPaginator.hasMore.value,
            noDataWidget: _EmptyFaq(onRetry: controller.loadFaq),
            builder: (_) {
              if (controller.faqs.isEmpty) {
                return _EmptyFaq(onRetry: controller.loadFaq);
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                padding: EdgeInsets.zero,

                // Existing FAQ items + loading-more indicator.
                itemCount: controller.faqs.length,

                separatorBuilder: (_, _) => SizedBox(height: 4.h),

                itemBuilder: (context, index) {
                  final faq = controller.faqs[index];

                  return HelpSupportFaqItem(faq: faq);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EmptyFaq extends StatelessWidget {
  const _EmptyFaq({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.help_outline_rounded,
              color: AppColors.primaryColor,
              size: 28.sp,
            ),
          ),
          Gap(12.h),
          Text(
            AppStrings.noFaqYet.tr,
            textAlign: TextAlign.center,
            style: context.titleMedium.copyWith(
              color: AppColors.darkTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(6.h),
          Text(
            AppStrings.noFaqMessage.tr,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
          Gap(10.h),
          TextButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh_rounded, size: 16.sp),
            label: Text(AppStrings.tryAgain.tr),
          ),
        ],
      ),
    );
  }
}
