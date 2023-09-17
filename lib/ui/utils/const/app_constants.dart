import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';

const String appName = 'Restaurant Menu';

bool getIsIOSPlatform() => Platform.isIOS;

bool getIsAppleSignInSupport() => (iosVersion >= 13);
int iosVersion = 11;

String getDeviceType() => getIsIOSPlatform() ? 'iphone' : 'android';

/// global context and ref for - used for unauthorized token
BuildContext? globalContext;
WidgetRef? globalRef;


/// Common Static Images
String commonImage =
    'https://images.unsplash.com/photo-1677611998429-1baa4371456b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80';




///Show Log
showLog(String str) {
  debugPrint('-> $str');
}

///Set Width
double setWidth(var width) {
  return ScreenUtil().setWidth(width);
}

///Set SP
double setSp(var fontSize) {
  return ScreenUtil().setSp(fontSize);
}



/// Hide Keyboard
hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year - 3, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day + 6);
