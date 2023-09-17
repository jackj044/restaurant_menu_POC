import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';

class CommonDropdownInputFormField<T> extends StatelessWidget {
  final String? placeholderImage;
  final double? placeholderImageHeight;
  final double? placeholderImageWidth;
  final double? placeholderImageHorizontalPadding;
  final String? placeholderText;
  final TextStyle? placeholderTextStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? fieldWidth;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final bool? isEnable;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final TextStyle? fieldTextStyle;
  final TextStyle? dropDownTextItemStyle;
  final String? Function(T? value)? validator;

  final InputDecoration? inputDecoration;

  final double? bottomFieldMargin;
  final List<T> menuItems;
  final T? defaultValue;
  final void Function(T? value)? onChanged;
  final List<Widget> Function(BuildContext context)? selectedItemBuilder;

  const CommonDropdownInputFormField(
      {Key? key,
      this.placeholderImage,
      this.placeholderImageHeight,
      this.placeholderImageWidth,
      this.placeholderImageHorizontalPadding,
      this.placeholderText,
      this.placeholderTextStyle,
      this.hintText,
      this.hintTextStyle,
      this.fieldWidth,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.isEnable,
      this.prefixWidget,
      this.suffixWidget,
      this.inputDecoration,
      this.bottomFieldMargin,
      this.fieldTextStyle,
      required this.menuItems,
      this.defaultValue,
      required this.onChanged,
      this.selectedItemBuilder,
      this.dropDownTextItemStyle,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: fieldWidth ?? double.infinity,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomFieldMargin ?? 0),
            child: ButtonTheme(
              alignedDropdown: true,
              padding: const EdgeInsets.all(0),
              child: DropdownButtonFormField<T>(
                isExpanded: true,
                style: fieldTextStyle ?? TextStyles.regular,
                value: defaultValue,
                iconSize: 14.h,
                validator: validator,
                padding: EdgeInsets.zero,
                icon: suffixWidget ??
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20.sp,
                      color: AppColors.black,
                    ).alignAtCenter(),
                items: menuItems.map<DropdownMenuItem<T>>((T value) {
                  // if (value is Choices) {
                  //   return DropdownMenuItem<T>(
                  //     value: value,
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 4.w),
                  //       child: Text(value.label ?? '',
                  //           style: dropDownTextItemStyle ??
                  //               TextStyles.regular.copyWith(
                  //                   color: AppColors.textWhiteByNewBlack2(),
                  //                   fontSize: 14.sp)),
                  //     ),
                  //   );
                  // } else {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        value.toString(),
                        style: dropDownTextItemStyle ?? TextStyles.regular.copyWith(color: AppColors.black, fontSize: 14.sp),
                      ),
                    ),
                  );
                  // }
                }).toList(),
                onChanged: onChanged,
                selectedItemBuilder: selectedItemBuilder,
                decoration: InputDecoration(
                    enabled: isEnable ?? true,
                    counterText: '',
                    filled: true,
                    fillColor: backgroundColor ?? AppColors.transparent,
                    suffixIcon: suffixWidget != null ? Padding(padding: const EdgeInsets.all(2), child: suffixWidget) : null,
                    prefixIcon: prefixWidget,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(0.w, 5.h, 5.w, 5.h),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.grey5B5B5B,
                        width: borderWidth ?? 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor ?? AppColors.grey5B5B5B,
                        width: borderWidth ?? 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.clrRedAccent,
                        width: borderWidth ?? 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor ?? AppColors.grey5B5B5B,
                        width: borderWidth ?? 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.clrRedAccent,
                        width: borderWidth ?? 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                    ),
                    border: InputBorder.none,
                    hintText: hintText,
                    alignLabelWithHint: true,
                    hintStyle: hintTextStyle),
              ),
            ),
          ),
        )
      ],
    );
  }
}
/*
Widget Usage

CommonInputFormField(
  textEditingController: _mobileController,
  suffixWidget: Image.asset(Assets.imagesIcApple),
  validator: validateEmail,
  backgroundColor: AppColors.pinch,
  prefixWidget: Image.asset(Assets.imagesIcApple),
  placeholderImage: Assets.imagesIcApple,
  placeholderText: 'Mobile Number',
)
*/
