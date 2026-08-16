import 'package:som_spot/share/export/screen_export.dart';

class AppLocationSuggestions extends StatelessWidget {
  final List<Map<String, dynamic>> suggestions;
  final ValueChanged<Map<String, dynamic>> onTap;

  const AppLocationSuggestions({
    super.key,
    required this.suggestions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
      constraints: BoxConstraints(maxHeight: 200.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.backgroundsLinesColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: suggestions.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (_, index) {
          final item = suggestions[index];

          return ListTile(
            leading: const Icon(
              Iconsax.location,
              color: AppColors.primaryColor,
            ),
            title: Text(
              item["display_name"] ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium,
            ),
            onTap: () => onTap(item),
          );
        },
      ),
    );
  }
}
