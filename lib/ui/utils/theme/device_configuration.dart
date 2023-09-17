import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mobileDeviceConfiguration(BuildContext context) {
  return ScreenUtil.init(
    context,
    designSize: const Size(412, 847),
    minTextAdapt: true,
  );
}



webDeviceConfiguration(BuildContext context) {
  return ScreenUtil.init(
    context,
    designSize: const Size(1366, 767),
    minTextAdapt: true,);
}