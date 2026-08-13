import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:som_spot/utils/config/app_config.dart';

class LocationTileLayer extends StatelessWidget {
  const LocationTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: AppConfig.mapTilerUrlTemplate,

      userAgentPackageName: AppConfig.userAgentPackageName,
      // 'https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=${AppConfig.mapTilerApiKey}',
      // 'com.somspot.app',
      tileDisplay: const TileDisplay.fadeIn(
        duration: Duration(milliseconds: 250),
      ),

      maxNativeZoom: 22,
      maxZoom: 24,

      keepBuffer: 3,
      panBuffer: 2,

      errorTileCallback: (tile, error, stackTrace) {
        debugPrint('Tile failed: ${tile.coordinates} - $error');
      },

      tileBuilder: (context, child, tile) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: child,
        );
      },
    );
  }
}
