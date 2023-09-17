import 'package:hive/hive.dart';
import 'package:restaurant_menu_poc/ui/utils/const/app_constants.dart';

const String keyAppThemeDark = 'keyAppThemeDark';

const String keyCategoryDetails = 'keyCategoryDetails';
const String keyIsCatRes = 'keyIsCatRes';

class Session {
  Session._();

  static var userBox = Hive.box('userBox');

  static String getCategoryDetails() => (userBox.get(keyCategoryDetails) ?? '');

  static bool getIsCatRes() => (userBox.get(keyIsCatRes) ?? false);

  static bool? getIsAppThemeDark() => (userBox.get(keyAppThemeDark));

  ///Save Local Data
  static saveLocalData(String key, value) {
    // showLog('data - key $key value $value');
    userBox.put(key, value);
  }

  ///Save Local Data
  static setIsThemeModeDark(value) {
    userBox.put(keyAppThemeDark, value);
  }
}
