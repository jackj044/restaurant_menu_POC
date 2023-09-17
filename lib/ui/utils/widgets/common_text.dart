import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';

class CommonText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;
  final Color? clrfont;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final TextStyle? textStyle;

  const CommonText(
      {Key? key,
      this.title = '',
      this.fontWeight,
      this.fontStyle,
      this.fontSize,
      this.clrfont,
      this.maxLines,
      this.textAlign,
      this.textDecoration,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textScaleFactor: 1.0,
      //-- will not change if system fonts size changed
      maxLines: maxLines ?? 1,
      textAlign: textAlign ?? TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: textStyle ?? TextStyle(
              fontFamily: TextStyles.fontFamily,
              fontWeight: fontWeight ?? TextStyles.fwRegular,
              fontSize: fontSize ?? 14.sp,
              color: clrfont ?? AppColors.black,
              fontStyle: fontStyle ?? FontStyle.normal,
              decoration: textDecoration ?? TextDecoration.none),
    );
  }
}
