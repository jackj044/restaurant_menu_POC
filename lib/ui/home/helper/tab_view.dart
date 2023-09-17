import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';


/// Tab View Header
class TabView extends StatelessWidget {
  final String tabName;
  final bool isSelected;

  const TabView({super.key, required this.tabName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.white,
        border: Border.all(color: isSelected ? AppColors.primary : AppColors.black),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
      child: CommonText(
        title: tabName,
        textStyle: isSelected
            ? TextStyles.bold.copyWith(fontSize: 14.sp, color: AppColors.white)
            : TextStyles.medium.copyWith(fontSize: 14.sp, color: AppColors.black),
      ).alignAtCenter(),
    );
  }
}
