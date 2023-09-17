import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';

class DialogProgressBar extends StatelessWidget {
  final bool isLoading;
  final bool forPagination;

  const DialogProgressBar({
    Key? key,
    required this.isLoading,
    this.forPagination = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !(isLoading)
        ? const Offstage()
        : (forPagination)
            ? SizedBox(
                height: 70.h,
                child: const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                )),
              )
            : AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ))),
                ),
              );
  }
}
