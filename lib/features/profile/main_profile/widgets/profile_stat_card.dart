import 'package:som_spot/share/controller/screen_export.dart';

class ProfileStatCard extends StatelessWidget {
  final String label;
  final String value;

  const ProfileStatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toString(),
            style: context.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          Gap(2.h),
          Text(
            label,
            style: context.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
