import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';

class CommonCartButton extends StatelessWidget {
  final int count;
  final Function() onLikeTap;
  final Function() onMinusTap;
  final Function() onAddTap;

  const CommonCartButton({
    super.key,
    required this.count,
    required this.onLikeTap,
    required this.onMinusTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: count == 0
          ? InkWell(
              onTap: () {
                onAddTap();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10.w,),
                  Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 20.h,
                  ),
                  CommonText(
                    title: ' Add',
                    textStyle: TextStyles.medium.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                  ).alignAtCenter(),
                  SizedBox(width: 10.w,),
                ],
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    /// Remove from cart
                    onMinusTap();
                  },
                  child: Icon(
                    Icons.remove,
                    size: 15.h,
                    color: AppColors.white,
                  ),
                ),
                CommonText(
                  title: count.toString(),
                  textStyle: TextStyles.medium.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    /// Add from cart
                    onAddTap();
                  },
                  child: Icon(
                    Icons.add,
                    size: 20.h,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
    );
  }
}
