import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';

import '../../controller/customer_business_details_controller.dart';
import '../../shared/model/customer_buiness_details_model.dart';

class MerchantAboutTab extends GetView<CustomerBusinessDetailsController> {
  const MerchantAboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.businessStatus.value,
        errorMessage: controller.businessErrorMessage.value,

        loadingWidget: const _MerchantAboutSkeleton(),
        onRetry: controller.refreshBusinessDetails,

        builder: (_) {
          final business = controller.business.value!;

          return CustomRefreshIndicator(
            onRefresh: () async {
              await controller.refreshBusinessDetails();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ========================================================
                  // Description
                  // ========================================================
                  if (business.description.trim().isNotEmpty) ...[
                    Text(
                      business.description.trim(),
                      style: context.bodyMedium.copyWith(
                        color: AppColors.subtitleTextColor,
                        height: 1.5,
                      ),
                    ),
                    Gap(16.h),
                  ],

                  // ========================================================
                  // Details Card
                  // ========================================================
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Address
                        if (business.address.trim().isNotEmpty) ...[
                          _buildInfoRow(
                            context,
                            icon: Icons.location_on_outlined,
                            title: business.address.trim(),
                          ),
                        ],

                        // Opening Status
                        if (business.address.trim().isNotEmpty)
                          const Divider(
                            height: 24,
                            color: AppColors.backgroundsLinesColor,
                          ),

                        _buildOpeningHoursRow(context, business: business),

                        // Phone
                        if (business.phone.trim().isNotEmpty) ...[
                          const Divider(
                            height: 24,
                            color: AppColors.backgroundsLinesColor,
                          ),
                          _buildInfoRow(
                            context,
                            icon: Icons.phone_outlined,
                            title: business.phone.trim(),
                          ),
                        ],

                        // WhatsApp
                        if (business.whatsapp.trim().isNotEmpty) ...[
                          const Divider(
                            height: 24,
                            color: AppColors.backgroundsLinesColor,
                          ),
                          _buildInfoRow(
                            context,
                            icon: Icons.chat_bubble_outline_rounded,
                            title: business.whatsapp.trim(),
                            iconColor: Colors.green,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // ========================================================
                  // Gallery
                  // ========================================================
                  if (business.gallery.isNotEmpty) ...[
                    Gap(24.h),

                    Text(
                      AppStrings.gallery.tr,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),

                    Gap(12.h),

                    SizedBox(
                      height: 100.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: business.gallery.length,
                        separatorBuilder: (context, index) => Gap(12.w),
                        itemBuilder: (context, index) {
                          final imageUrl = business.gallery[index];

                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: CustomNetworkImage(
                              imageUrl: imageUrl,
                              width: 100.w,
                              height: 100.h,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  // ========================================================
                  // Rating
                  // ========================================================
                  if (business.ratingCount > 0) ...[
                    Gap(24.h),
                    _buildRatingSection(context, business: business),
                  ],

                  Gap(24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // Opening Hours
  // ============================================================

  Widget _buildOpeningHoursRow(
    BuildContext context, {
    required BusinessDetailsModel business,
  }) {
    final bool isOpen = business.isOpen;

    String? subtitle;

    if (isOpen && business.closesAt != null) {
      subtitle = "Closes at ${_formatTime(business.closesAt!)}";
    } else if (!isOpen && business.opensAt != null) {
      subtitle = "Opens at ${_formatTime(business.opensAt!)}";
    }

    return _buildInfoRow(
      context,
      icon: Icons.access_time,
      title: isOpen ? AppStrings.openNow.tr : AppStrings.closed.tr,
      subtitle: subtitle,
      titleColor: isOpen ? AppColors.success : AppColors.error,
    );
  }

  // ============================================================
  // Rating
  // ============================================================

  Widget _buildRatingSection(
    BuildContext context, {
    required BusinessDetailsModel business,
  }) {
    return Row(
      children: [
        Icon(Icons.star_rounded, color: Colors.amber, size: 22.sp),
        Gap(6.w),
        Text(
          business.ratingAvg.toStringAsFixed(1),
          style: context.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        Gap(6.w),
        Text(
          "(${business.ratingCount} reviews)",
          style: context.bodySmall.copyWith(color: AppColors.subtitleTextColor),
        ),
      ],
    );
  }

  // ============================================================
  // Info Row
  // ============================================================

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    Color? iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor ?? AppColors.primaryColor, size: 20.sp),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? AppColors.darkTextColor,
                ),
              ),
              if (subtitle != null) ...[
                Gap(2.h),
                Text(
                  subtitle,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Time Formatter
  // ============================================================

  String _formatTime(String time) {
    try {
      final parts = time.split(':');

      if (parts.length < 2) {
        return time;
      }

      int hour = int.parse(parts[0]);
      final minute = parts[1];

      final period = hour >= 12 ? 'PM' : 'AM';

      if (hour == 0) {
        hour = 12;
      } else if (hour > 12) {
        hour -= 12;
      }

      return '$hour:$minute $period';
    } catch (_) {
      return time;
    }
  }
}

// ============================================================
// About Tab Loading Skeleton
// ============================================================

class _MerchantAboutSkeleton extends StatelessWidget {
  const _MerchantAboutSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================================
          // Description Skeleton
          // ==========================================================
          _shimmerBox(width: double.infinity, height: 16.h),

          Gap(8.h),

          _shimmerBox(width: 280.w, height: 16.h),

          Gap(8.h),

          _shimmerBox(width: 220.w, height: 16.h),

          Gap(20.h),

          // ==========================================================
          // Details Card Skeleton
          // ==========================================================
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSkeletonInfoRow(),

                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),

                _buildSkeletonInfoRow(titleWidth: 90.w, subtitleWidth: 130.w),

                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),

                _buildSkeletonInfoRow(titleWidth: 160.w, showSubtitle: false),

                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),

                _buildSkeletonInfoRow(titleWidth: 150.w, showSubtitle: false),
              ],
            ),
          ),

          Gap(24.h),

          // ==========================================================
          // Gallery Title
          // ==========================================================
          _shimmerBox(width: 80.w, height: 20.h),

          Gap(12.h),

          // ==========================================================
          // Gallery Images
          // ==========================================================
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, index) => Gap(12.w),
              itemBuilder: (_, index) {
                return _shimmerBox(
                  width: 100.w,
                  height: 100.h,
                  borderRadius: 12.r,
                );
              },
            ),
          ),

          Gap(24.h),

          // ==========================================================
          // Rating Skeleton
          // ==========================================================
          Row(
            children: [
              _shimmerBox(width: 22.w, height: 22.w, borderRadius: 6.r),
              Gap(6.w),
              _shimmerBox(width: 35.w, height: 16.h),
              Gap(6.w),
              _shimmerBox(width: 90.w, height: 14.h),
            ],
          ),

          Gap(24.h),
        ],
      ),
    );
  }

  // ============================================================
  // Skeleton Info Row
  // ============================================================

  Widget _buildSkeletonInfoRow({
    double? titleWidth,
    double? subtitleWidth,
    bool showSubtitle = true,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoShimmerAnimate(
          isLoading: true,
          child: Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
          ),
        ),

        Gap(12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(width: titleWidth ?? 200.w, height: 16.h),

              if (showSubtitle) ...[
                Gap(6.h),
                _shimmerBox(width: subtitleWidth ?? 130.w, height: 13.h),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Generic Shimmer Box
  // ============================================================

  Widget _shimmerBox({
    required double width,
    required double height,
    double? borderRadius,
  }) {
    return AutoShimmerAnimate(
      isLoading: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
        ),
      ),
    );
  }
}
