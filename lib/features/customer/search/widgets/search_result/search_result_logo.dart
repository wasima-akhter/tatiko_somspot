import '../../../../../share/export/screen_export.dart';
import '../../../../../share/widgets/network_image/custom_network_image.dart';

class SearchResultLogo extends StatelessWidget {
  const SearchResultLogo({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: CustomNetworkImage(
        imageUrl: imageUrl,
        width: 72.w,
        height: 72.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
