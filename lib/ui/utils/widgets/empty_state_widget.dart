import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/show_up_transition.dart';

class EmptyStateWidget extends StatelessWidget {
  final EmptyState emptyStateFor;

  const EmptyStateWidget({
    Key? key,
    required this.emptyStateFor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imgName = '';
    String title = '';
    String subTitle = '';

    switch (emptyStateFor) {
      case EmptyState.noCatFound:
        title = 'No Categories Found';
        break;

      default:
      // imgName = AppAssets.imgNoErrorKnown;
        title = 'No Categories Found';
        break;
    }

    return Container(
      // color_assessment_running_test: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title.isNotEmpty)
              ShowUpTransition(
                  delay: 500,
                  child: Text(title, textAlign: TextAlign.center, style: TextStyles.semiBold.copyWith(fontSize: 16.sp))),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

enum EmptyState { noCatFound, noSubCatFound }
