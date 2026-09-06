import 'package:som_spot/share/export/screen_export.dart';

class DashboardSectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const DashboardSectionTitle({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: trailing != null
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: [
        Text(
          title.tr,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),

        ?trailing,
      ],
    );
  }
}
