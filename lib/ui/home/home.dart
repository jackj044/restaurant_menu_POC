import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:restaurant_menu_poc/ui/home/mobile/home_mobile.dart';
import 'package:restaurant_menu_poc/ui/home/web/home_web.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  ///Build
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const HomeMobile();
    }, desktop: (BuildContext context) {
      return const HomeWeb();
    });
  }
}
