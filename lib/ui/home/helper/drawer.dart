import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';

class DrawerView extends StatelessWidget {
  final String title;
  final bool isSelected;

  const DrawerView({super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isSelected ? 10.r : 0),
            color: isSelected ? AppColors.white : AppColors.transparent,
          ),
          child: CommonText(
            title: title,
            maxLines: 2,
            textStyle: isSelected
                ? TextStyles.bold.copyWith(
                    color: AppColors.black,
                    fontSize: 20.sp,
                  )
                : TextStyles.regular.copyWith(
                    color: AppColors.black.withOpacity(0.7),
                    fontSize: 18.sp,
                  ),
          ).alignAtCenter(),
        ).paddingSymmetric(horizontal: 10.w),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
