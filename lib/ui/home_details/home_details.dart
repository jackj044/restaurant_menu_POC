import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:restaurant_menu_poc/ui/home_details/mobile/home_details_mobile.dart';

import 'package:restaurant_menu_poc/ui/home_details/web/home_details_web.dart';

class HomeDetails extends StatelessWidget {
  const HomeDetails({Key? key}) : super(key: key);

  ///Build
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(mobile: (BuildContext context) {
      return const HomeDetailsMobile();
    }, desktop: (BuildContext context) {
      return const HomeDetailsWeb();
    });
  }
}
