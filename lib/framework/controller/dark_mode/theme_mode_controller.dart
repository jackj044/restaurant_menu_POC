import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurant_menu_poc/framework/utility/session.dart';

final themeModeController =
    ChangeNotifierProvider.autoDispose((ref) => ThemeModeController());

@injectable
class ThemeModeController extends ChangeNotifier {
  var themeMode =
      (Session.getIsAppThemeDark() ?? false) ? ThemeMode.dark : ThemeMode.light;

  void updateThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    Session.setIsThemeModeDark(themeMode == ThemeMode.dark ? true : false);
    notifyListeners();
  }
}
