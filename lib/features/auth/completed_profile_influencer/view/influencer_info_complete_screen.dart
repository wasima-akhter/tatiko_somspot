import 'package:flutter/services.dart';
import 'package:som_spot/share/widgets/ui_status_builder/error_card.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/custom_text/custom_text.dart';
import '../../../../share/widgets/dropdown/custom_dropdown_field.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../../../core/category/controller/category_controller.dart';
import '../controller/completed_profile_influencer_controller.dart';

class InfluencerInfoCompleteScreen extends StatefulWidget {
  const InfluencerInfoCompleteScreen({super.key});

  @override
  State<InfluencerInfoCompleteScreen> createState() =>
      _InfluencerInfoCompleteScreenState();
}

class _InfluencerInfoCompleteScreenState
    extends State<InfluencerInfoCompleteScreen> {
  late final CompletedProfileInfluencerController controller;
  late final CategoryController categoryController;

  @override
  void initState() {
    super.initState();

    controller = CompletedProfileInfluencerController.to;

    categoryController = Get.find<CategoryController>(
      tag: 'influencerCategory',
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (categoryController.categories.isEmpty) {
        categoryController.loadInitialCategories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = CompletedProfileInfluencerController.to;

    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(24.h),

              Text(
                "Influencer Details",
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),

              Gap(8.h),

              Text(
                "Tell us about your audience and social presence",
                style: context.bodyLarge.copyWith(
                  color: AppColors.subtitleTextColor,
                ),
              ),

              Gap(22.h),

              Text(
                "Influencer Type",
                style: context.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
              ),

              Gap(10.h),

              Obx(
                () => CustomDropdownField<String>(
                  hintText: "Select Influencer Type",
                  items: controller.influencerCategories
                      .map((e) => e.name)
                      .toList(),
                  value: controller.selectedInfluencerCategoryName.isEmpty
                      ? null
                      : controller.selectedInfluencerCategoryName,
                  isRequired: true,

                  onChanged: (value) {
                    final category = controller.influencerCategories
                        .firstWhereOrNull((e) => e.name == value);

                    controller.selectInfluencerCategory(category?.id);
                  },

                  onLoadMore: categoryController.loadMoreCategories,
                  hasMore: categoryController.categoryPaginator.hasMore.value,
                  isLoadingMore:
                      categoryController
                          .categoryPaginator
                          .loadMoreStatus
                          .value ==
                      ApiStatus.loading,

                  emptyPlaceholder: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.theme.hintColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 18,
                            color: context.theme.colorScheme.primary,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Obx(
                          () =>
                              categoryController
                                      .categoryPaginator
                                      .status
                                      .value ==
                                  ApiStatus.loading
                              ? SizedBox(
                                  height: 20.w,
                                  width: 20.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'No influencer types available',
                                        fontWeight: FontWeight.w600,
                                        maxLines: 1,
                                      ),

                                      const SizedBox(height: 4),

                                      CustomText(
                                        text:
                                            'Influencer types are managed by the admin. '
                                            'Please check back once they’re available.',
                                        textAlign: TextAlign.start,
                                        color: AppColors.grayTextSecondaryColor,
                                        maxLines: 4,
                                      ),

                                      const SizedBox(height: 6),

                                      CustomText(
                                        text:
                                            'You can’t complete your profile until an influencer type '
                                            'is available.',
                                        textAlign: TextAlign.start,
                                        color: AppColors.error,
                                        maxLines: 3,
                                      ),

                                      const SizedBox(height: 8),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: RetryButton(
                                          onTap: () {
                                            categoryController
                                                .loadInitialCategories();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Gap(16.h),

              CustomTextField(
                controller: controller.bioController,
                title: "Bio",
                hintText:
                    "Example: I run the biggest food review page in Mogadishu",
                maxLines: 5,
                prefixIcon: Icon(
                  Iconsax.text,
                  size: 20.sp,
                  color: AppColors.hintTextColor,
                ),
              ),

              Gap(16.h),

              CustomTextField(
                controller: controller.followerCountController,
                title: "Follower Count",
                hintText: "Enter total followers",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(
                  Iconsax.profile_2user,
                  size: 20.sp,
                  color: AppColors.hintTextColor,
                ),
              ),

              Gap(24.h),

              Text(
                "Social Accounts",
                style: context.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
              ),

              Gap(10.h),

              CustomTextField(
                controller: controller.tiktokController,
                title: "TikTok",
                hintText: "@username",
                prefixIcon: Icon(
                  Iconsax.video,
                  size: 20.sp,
                  color: AppColors.hintTextColor,
                ),
              ),

              Gap(16.h),

              CustomTextField(
                controller: controller.instagramController,
                title: "Instagram",
                hintText: "@username",
                prefixIcon: Icon(
                  Iconsax.instagram,
                  size: 20.sp,
                  color: AppColors.hintTextColor,
                ),
              ),

              Gap(16.h),

              CustomTextField(
                controller: controller.facebookController,
                title: "Facebook",
                hintText: "Page username",
                prefixIcon: Icon(
                  Icons.facebook,
                  size: 20.sp,
                  color: AppColors.hintTextColor,
                ),
              ),

              Gap(40.h),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Continue",
                    isLoading: controller.isLoading.value,
                    onTap: controller.completeCreatorProfile,
                  ),
                ),
              ),

              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
