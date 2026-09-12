# som_spot

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Check which packages u did not use:

for package in cupertino_icons get_it dio go_router internet_connection_checker_plus mime http_parser shared_preferences intl gap flutter_svg cached_network_image iconsax pinput flutter_screenutil infinite_scroll_pagination dotted_border easy_date_timeline flutter_calenders carousel_slider image_picker stylish_bottom_bar url_launcher share_plus google_maps_flutter dropdown_button2 device_preview logger geolocator geocoding google_places_flutter jwt_decoder shimmer flutter_map latlong2 auto_shimmer_animate fl_chart flutter_rating_bar get_storage jwt_decode flutter_html video_player media_kit media_kit_video media_kit_libs_video qr_flutter gal; do
if grep -R -q "package:$package/" lib/; then
echo "✅ $package"
else
echo "❌ $package"
fi
done
