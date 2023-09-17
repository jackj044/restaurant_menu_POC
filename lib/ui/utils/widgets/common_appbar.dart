import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/ui/routing/stack.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';

class CommonAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isLeadingEnable;
  final bool isDrawerEnable;
  final GestureTapCallback? onLeadingPress;
  final GestureTapCallback? onTitlePress;
  final String title;
  final String? leftImage;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool? isTitleWithImage;
  final String? imgText;

  const CommonAppBar(
      {Key? key,
      this.isLeadingEnable = true,
      this.isDrawerEnable = false,
      this.onLeadingPress,
      this.leftImage,
      this.title = '',
      this.backgroundColor,
      this.titleColor,
      this.isTitleWithImage = false,
      this.imgText = '',
      this.actions,
      this.onTitlePress})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: true,
      leadingWidth: 55.w,
      leading: (isLeadingEnable)
          ? ((isDrawerEnable)
                  ? InkWell(
                      onTap: onLeadingPress ??
                          () {
                            // FocusScope.of(context).unfocus();
                            // CustomDrawerState.openDrawer();
                          },
                      child: const Icon(Icons.arrow_back_outlined, color: AppColors.white),
                    )
                  : InkWell(
                      onTap: onLeadingPress ??
                          () {
                            if (ref.read(navigationStackController).items.length > 1) {
                              ref.read(navigationStackController).pop();
                            } else {}
                          },
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: AppColors.white,
                      ),
                    ))
              .paddingAll(8.h)
          : const Offstage(),
      elevation: 0,
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.scaffoldBGByTheme(),
      title: isTitleWithImage == true
          ? InkWell(
              onTap: onTitlePress ?? () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                  CommonText(
                    title: title,
                    textStyle: TextStyles.medium.copyWith(
                      color: AppColors.white,
                      fontSize: 12.sp,
                      fontFamily: TextStyles.secondaryFontFamily,
                    ),
                  ),
                ],
              ),
            )
          : CommonText(
              title: title,
              textAlign: TextAlign.center,
              textStyle: TextStyles.medium.copyWith(fontSize: 16.sp, color: titleColor ?? AppColors.white)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

/*
Widget Usage
const CommonAppBar(
        title: "Home",
      ),
* */
