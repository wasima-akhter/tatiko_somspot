import 'package:som_spot/features/nav/controller/navigation_controller.dart';

import '../../share/controller/screen_export.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, this.index = 0});

  final int index;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _controller = NavigationControllerMain.to;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.selectedNavIndex.value = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _controller.getPages()[_controller.selectedNavIndex.value];
      }),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: EdgeInsets.only(top: 20.h, bottom: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      // top: false → don't reserve status-bar space up here.
      // bottom: true (default) → pads for home-indicator / gesture bar.
      child: SafeArea(
        top: false,
        child: Container(
          // height: 64.h, // fixed height keeps every tab item the same size
          padding: EdgeInsets.only(left: 15, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _controller.icons.length,
              (index) => _buildNavItem(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _controller.selectedNavIndex.value = index,
        child: Obx(() {
          final isSelected = _controller.selectedNavIndex.value == index;
          final color = isSelected
              ? AppColors.primaryColor
              : AppColors.grayTextSecondaryColor;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_controller.icons[index], color: color, size: 24.sp),
              SizedBox(height: 4.h),
              Text(
                _controller.labels[index].tr,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
