import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:restaurant_menu_poc/ui/splash/mobile/splash_mobile.dart';
import 'package:restaurant_menu_poc/ui/splash/web/splash_web.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  ///Build
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const SplashMobile();
    }, desktop: (BuildContext context) {
      return const SplashWeb();
    });
  }
}
