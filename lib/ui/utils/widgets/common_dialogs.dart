import 'dart:ui';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_button.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';

/// Confirmation dialog  message
showConfirmationDialog(BuildContext context, String title, String message,
    String btn1Name, String btn2Name, Function(bool isPositive) didTakeAction) {
  return showDialog(
      barrierDismissible: true,
      context: context,
      barrierColor: AppColors.bg1A2D3170,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Dialog(
              backgroundColor: AppColors.white,
              insetPadding: EdgeInsets.all(16.sp),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(15.r))),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16.w, right: 16.w, top: 22.h, bottom: 15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        message == '' ? SizedBox(height: 20.h) : const SizedBox(),
                        Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyles.medium.copyWith(
                                color: AppColors.black, fontSize: 16.sp)),
                        message != ''
                            ? SizedBox(
                                height: 20.h,
                              )
                            : const SizedBox(),
                        Text(message,
                            textAlign: TextAlign.center,
                            style: TextStyles.regular.copyWith(
                                color: AppColors.black, fontSize: 12.sp)),
                        SizedBox(
                          height: 33.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonButton(
                                width: 139.w,
                                height: 49.h,
                                isGradient: false,
                                borderRadius: BorderRadius.circular(25.r),
                                buttonText: btn1Name,
                                onTap: () {
                                  Navigator.pop(context);
                                  Future.delayed(const Duration(milliseconds: 80),
                                      () {
                                    didTakeAction(true);
                                  });
                                },
                                borderColor: AppColors.green3A4161,
                                backgroundColor: AppColors.white,
                                buttonTextColor: AppColors.black1A2D31),
                            SizedBox(
                              width: 15.w,
                            ),
                            CommonButton(
                                buttonText: btn2Name,
                                width: 139.w,
                                height: 49.h,
                                borderRadius: BorderRadius.circular(25.r),
                                onTap: () {
                                  Navigator.pop(context);
                                  Future.delayed(const Duration(milliseconds: 80),
                                      () {
                                    didTakeAction(false);
                                  });
                                },
                                backgroundColor: AppColors.white,
                                buttonTextColor: AppColors.white),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ));
}

/// Message Dialog
showMessageDialog(
    BuildContext context, String message, Function()? didDismiss) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: AppColors.bg1A2D3170,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 6, sigmaX: 6),
        child: Dialog(
              backgroundColor: AppColors.white,
              insetPadding: EdgeInsets.all(16.sp),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5))),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    // height: ScreenUtil().setHeight(220),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  // fontWeight: TextStyles.medium,
                                  fontFamily: TextStyles.fontFamily),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CommonButton(
                            buttonTextColor: AppColors.white,
                            backgroundColor: AppColors.clr5e5e5e,
                            borderColor: AppColors.black,
                            width: 150.w,
                            buttonText: 'Ok',
                            onTap: () {
                              Navigator.pop(context);
                              if (didDismiss != null) {
                                Future.delayed(const Duration(milliseconds: 80),
                                    () {
                                  didDismiss();
                                });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ));
}

/// Coming Soon message
// showComingSoonDialog(BuildContext context, String message, String btn1Name,
//     Function(bool isPositive) didTakeAction,
//     {bool isButtonEnabled = false}) {
//   return showDialog(
//       barrierDismissible: true,
//       context: context,
//       barrierColor: AppColors.bg1A2D3170,
//       builder: (context){
//         Future.delayed(const Duration(seconds: 4), () {
//           Navigator.of(context).pop(true);
//         });
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
//           child: Dialog(
//               backgroundColor: AppColors.white,
//               insetPadding: EdgeInsets.all(16.sp),
//               shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(ScreenUtil().setWidth(15.r))),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: 20.w, right: 20.w, top: 22.h, bottom: 15.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Lottie.asset(
//                           AppAssets.jsonPlane,
//                           height: 316.h,
//                           width: 209.w,
//                         ),
//                         message == '' ? SizedBox(height: 20.h) : const SizedBox(),
//                         Text(LocalizationStrings().keyComingSoon,
//                             textAlign: TextAlign.center,
//                             style: TextStyles.medium.copyWith(
//                                 color: AppColors.black, fontSize: 16.sp)),
//                         message != ''
//                             ? SizedBox(
//                                 height: 27.h,
//                               )
//                             : const SizedBox(),
//                         Text(message,
//                             textAlign: TextAlign.center,
//                             style: TextStyles.regular.copyWith(
//                                 color: AppColors.black, fontSize: 12.sp)),
//                         SizedBox(
//                           height: 34.h,
//                         ),
//                         isButtonEnabled == true
//                             ? CommonButton(
//                                 width: 293.w,
//                                 height: 49.h,
//                                 borderRadius: BorderRadius.circular(25.r),
//                                 buttonText: btn1Name,
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                   Future.delayed(const Duration(milliseconds: 80),
//                                       () {
//                                     didTakeAction(true);
//                                   });
//                                 },
//                                 borderColor: AppColors.black,
//                                 backgroundColor: AppColors.white,
//                                 isGradient: false,
//                                 buttonTextColor: AppColors.black)
//                             : const Offstage(),
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//         );});
// }

///not access dialog
// showAccessDialog(BuildContext context, String message, String btn1Name,
//     Function(bool isPositive) didTakeAction,
//     {bool isButtonEnabled = false}) {
//   return showDialog(
//       barrierDismissible: true,
//       context: context,
//       barrierColor: AppColors.bg1A2D3170,
//       builder: (context) => BackdropFilter(
//         filter: ImageFilter.blur(sigmaY: 6, sigmaX: 6),
//         child: Dialog(
//               backgroundColor: AppColors.white,
//               insetPadding: EdgeInsets.all(16.sp),
//               shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(ScreenUtil().setWidth(15.r))),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: 20.w, right: 20.w, top: 22.h, bottom: 15.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Lottie.asset(
//                           AppAssets.jsonPlane,
//                           height: 316.h,
//                           width: 209.w,
//                         ),
//                         message == '' ? SizedBox(height: 20.h) : const SizedBox(),
//                         Text(LocalizationStrings().keyOpps,
//                             textAlign: TextAlign.center,
//                             style: TextStyles.medium.copyWith(
//                                 color: AppColors.black, fontSize: 16.sp)),
//                         message != ''
//                             ? SizedBox(
//                                 height: 27.h,
//                               )
//                             : const SizedBox(),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 50.w),
//                           child: Text(message,
//                               textAlign: TextAlign.center,
//                               style: TextStyles.regular.copyWith(
//                                   color: AppColors.black, fontSize: 12.sp)),
//                         ),
//                         SizedBox(
//                           height: 34.h,
//                         ),
//                         isButtonEnabled == true
//                             ? CommonButton(
//                                 width: 293.w,
//                                 height: 49.h,
//                                 borderRadius: BorderRadius.circular(25.r),
//                                 buttonText: btn1Name,
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                   Future.delayed(const Duration(milliseconds: 80),
//                                       () {
//                                     didTakeAction(true);
//                                   });
//                                 },
//                                 borderColor: AppColors.black,
//                                 backgroundColor: AppColors.white,
//                                 isGradient: false,
//                                 buttonTextColor: AppColors.black)
//                             : const Offstage(),
//                         SizedBox(
//                           height: 20.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//       ));
// }

/// Common Widget Dialog
showCommonWidgetDialog(
    BuildContext context, Widget widget, Function()? didDismiss,
    {bool isAnimated = false, bool isBarrierDismissible = true}) {
  return showDialog(
    barrierDismissible: isBarrierDismissible,
    context: context,
    barrierColor: AppColors.bg1A2D3170,
    builder: (context) {
      if (isAnimated == false) {
        // Future.delayed(const Duration(seconds: 3), () {
        //   Navigator.pop(context);
        //   if (didDismiss != null) {
        //     didDismiss();
        //   }
        // });
      }
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Dialog(
          elevation: 0,
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.all(16.sp),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15.r))),
          child: Wrap(
            // alignment: Alignment.center,
            children: <Widget>[
              widget,
            ],
          ),
        ),
      );
    },
  );
}

/// Common Widget Dialog
showCommonAgeDialog(BuildContext context, Widget widget, Function()? didDismiss,
    {bool isAnimated = false, bool isBarrierDismissible = true}) {
  return showDialog(
    barrierDismissible: isBarrierDismissible,
    context: context,
    barrierColor: AppColors.bg1A2D3170,
    builder: (context) {
      if (isAnimated == false) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
          if (didDismiss != null) {
            didDismiss();
          }
        });
      }
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 6, sigmaX: 6),
        child: AlertDialog(
          elevation: 0,
          backgroundColor: AppColors.transparent,
          contentPadding: EdgeInsets.only(top: 0.sp),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15.r))),
          content: Wrap(
            // alignment: Alignment.center,
            children: <Widget>[
              widget,
            ],
          ),
        ),
      );
    },
  );
}

/// Common Success Dialogs
// showCommonSuccessDialog(
//     BuildContext context, Widget widget, Function()? didDismiss,
//     {bool isAnimated = false,
//     bool isBarrierDismissible = true,
//     required String title,
//     required String subTitle}) {
//   return showDialog(
//     barrierDismissible: isBarrierDismissible,
//     context: context,
//     barrierColor: AppColors.bg1A2D3170,
//     builder: (context) {
//       if (isAnimated == false) {
//         Future.delayed(const Duration(seconds: 3), () {
//           Navigator.pop(context);
//           if (didDismiss != null) {
//             didDismiss();
//           }
//         });
//       }
//       return BackdropFilter(
//         filter: ImageFilter.blur(sigmaY: 6, sigmaX: 6),
//         child: Dialog(
//           backgroundColor: AppColors.white,
//           insetPadding: EdgeInsets.all(16.sp),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15.r))),
//           child: Wrap(
//             // alignment: Alignment.center,
//             children: <Widget>[
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Lottie.asset(AppAssets.jsonVerifySuccessful,
//                       height: 236.h, width: 236.h),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   CommonText(
//                     title: title,
//                     textStyle: TextStyles.semiBold.copyWith(
//                       color: AppColors.black,
//                       fontSize: 20.sp,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: 12.h,
//                   ),
//                   CommonText(
//                     title: subTitle,
//                     textStyle: TextStyles.regular.copyWith(
//                       color: AppColors.black,
//                       fontSize: 12.sp,
//                       fontFamily: TextStyles.secondaryFontFamily,
//                     ),
//                     maxLines: 2,
//                     textAlign: TextAlign.center,
//                   ).paddingOnly(left: 20.w, right: 20.w),
//                   SizedBox(
//                     height: 40.h,
//                   ),
//                 ],
//               ).paddingOnly(left: 16.w, right: 16.w),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
