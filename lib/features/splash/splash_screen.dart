import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:som_spot/core/custom_assets/assets.gen.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      AppRouter.route.pushNamed(RoutePath.chooseLanguageScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.splashlogo.image(),
            const Gap(20),
            Text("Discover. Connect. Save.", style: context.headlineSmall),
          ],
        ),
      ),
    );
  }
}
