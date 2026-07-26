import 'package:som_spot/features/customer/customer_home/model/merchant_model.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

class MerchantAboutTab extends StatelessWidget {
  final MerchantModel merchant;

  const MerchantAboutTab({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          Text(
            "Authentic Somali cuisine featuring the best camel meat, suqaar, and fresh bariis in town.",
            style: context.bodyMedium.copyWith(
              color: AppColors.subtitleTextColor,
              height: 1.5,
            ),
          ),
          Gap(16.h),

          // Details Card
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
                _buildInfoRow(
                  context,
                  icon: Icons.location_on_outlined,
                  title: "Maka Al Mukarama Road, Mogadishu",
                  subtitle: "${merchant.distance} away",
                ),
                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),
                _buildInfoRow(
                  context,
                  icon: Icons.access_time,
                  title: merchant.isOpen
                      ? AppStrings.openNow.tr
                      : AppStrings.closed.tr,
                  subtitle: "Closes at 10:00 PM",
                  titleColor: merchant.isOpen
                      ? AppColors.success
                      : AppColors.error,
                ),
                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),
                _buildInfoRow(
                  context,
                  icon: Icons.phone_outlined,
                  title: "+252 61 234 5678",
                ),
                const Divider(
                  height: 24,
                  color: AppColors.backgroundsLinesColor,
                ),
                _buildInfoRow(
                  context,
                  icon: Icons.chat_bubble_outline_rounded,
                  title: "+252 61 234 5678",
                  iconColor: Colors.blue,
                ),
              ],
            ),
          ),
          Gap(24.h),

          // Gallery Section
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
              itemCount: 3,
              separatorBuilder: (context, index) => Gap(12.w),
              itemBuilder: (context, index) {
                final images = [
                  "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=300&auto=format&fit=crop",
                  "https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=300&auto=format&fit=crop",
                  "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=300&auto=format&fit=crop",
                ];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CustomNetworkImage(
                    imageUrl: images[index],
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

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
}
