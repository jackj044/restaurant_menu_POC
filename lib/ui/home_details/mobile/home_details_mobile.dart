import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_menu_poc/framework/controller/home_details/home_details_controller.dart';
import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/ui/home/helper/cart_button.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/device_configuration.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/cache_image.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_appbar.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/show_up_transition.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeDetailsMobile extends ConsumerStatefulWidget {
  const HomeDetailsMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeDetailsMobile> createState() => _HomeDetailsMobileState();
}

class _HomeDetailsMobileState extends ConsumerState<HomeDetailsMobile> {
  /// Page Controller
  PageController controller = PageController();

  ItemScrollController scrollController = ItemScrollController();

  ///Init
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final homeDetailsWatch = ref.watch(homeDetailsController);
      homeDetailsWatch.disposeController();
      await homeDetailsWatch.getCatData();
    });
  }

  ///Dispose
  @override
  void dispose() {
    super.dispose();
  }

  ///Build
  @override
  Widget build(BuildContext context) {
    mobileDeviceConfiguration(context);
    final homeDetailsWatch = ref.watch(homeDetailsController);
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Details',
        backgroundColor: AppColors.primary,
        actions: [
          Visibility(
            visible: homeDetailsWatch.subCatList != null,
            child: PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  ...List.generate(
                    (homeDetailsWatch.subCatList?.subCatDetails?.length ?? 0),
                    (index) => PopupMenuItem(
                      onTap: () {
                        homeDetailsWatch.updateFilter(homeDetailsWatch.subCatList?.subCatDetails?[index].name ?? '');
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: CommonText(
                              title: homeDetailsWatch.subCatList?.subCatDetails?[index].name ?? '',
                              maxLines: 4,
                              textStyle:
                                  homeDetailsWatch.subCatList?.subCatDetails?[index].name == homeDetailsWatch.selectedFilter
                                      ? TextStyles.bold.copyWith(fontSize: 14.sp, color: AppColors.primary)
                                      : TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                            ),
                          ),
                          Visibility(
                            visible: homeDetailsWatch.subCatList?.subCatDetails?[index].name == homeDetailsWatch.selectedFilter,
                            child: const Icon(
                              Icons.check,
                              color: AppColors.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ];
              },
              onSelected: (String value) {
                homeDetailsWatch.updateFilter(value);
              },
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: (homeDetailsWatch.categoryList != null || homeDetailsWatch.subCatList != null) ? bodyWidget() : const Offstage(),
    );
  }

  /// Check Whether Sub categories are there or not
  bool getIsSubCatModel() {
    final homeDetailsWatch = ref.watch(homeDetailsController);
    return homeDetailsWatch.subCatList != null;
  }

  /// Body Widget
  Widget bodyWidget() {
    final homeDetailsWatch = ref.watch(homeDetailsController);
    return ShowUpTransition(
      delay: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CacheImage(
              imageURL: getIsSubCatModel()
                  ? (homeDetailsWatch.subCatList?.subCatImage ?? '')
                  : (homeDetailsWatch.categoryList?.catImage ?? ''),
              height: 200.h,
              width: double.infinity,
            ).alignAtCenter(),
          ),
          Row(
            children: [
              Expanded(
                child: CommonText(
                  title: getIsSubCatModel()
                      ? (homeDetailsWatch.subCatList?.subCatName ?? '')
                      : (homeDetailsWatch.categoryList?.catName ?? ''),
                  textStyle: TextStyles.semiBold.copyWith(fontSize: 18.sp, color: AppColors.black),
                  maxLines: 4,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              ClipOval(
                child: InkWell(
                  onTap: () {
                    homeDetailsWatch.updateLikesCount();
                  },
                  child: Material(
                    elevation: 5.h,
                    child: Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: getIsSubCatModel()
                          ? Icon(
                              homeDetailsWatch.subCatList?.subCatLikesStatus == false ? Icons.favorite_border : Icons.favorite,
                              color: homeDetailsWatch.subCatList?.subCatLikesStatus != false
                                  ? AppColors.clrRedAccent
                                  : AppColors.clrRedAccent,
                            )
                          : Icon(
                              homeDetailsWatch.categoryList?.catLikesStatus == false ? Icons.favorite_border : Icons.favorite,
                              color: homeDetailsWatch.categoryList?.catLikesStatus != false
                                  ? AppColors.clrRedAccent
                                  : AppColors.clrRedAccent,
                            ),
                    ),
                  ),
                ),
              )
            ],
          ).paddingOnly(top: 20.h),
          Row(
            children: [
              Flexible(
                child: CommonText(
                  title: getIsSubCatModel()
                      ? (homeDetailsWatch.subCatList?.subCatDesc ?? '')
                      : (homeDetailsWatch.categoryList?.catDesc ?? ''),
                  textStyle: TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black.withOpacity(0.4)),
                  maxLines: 10,
                ),
              ),
              CommonText(
                title: getIsSubCatModel()
                    ? ('\$${homeDetailsWatch.subCatList?.subCatDetails?[homeDetailsWatch.subCatList?.subCatSelectedindex ?? 0].price ?? ''}')
                    : ('\$${homeDetailsWatch.categoryList?.catPrice ?? ''}'),
                textStyle: TextStyles.medium.copyWith(fontSize: 14.sp, color: AppColors.black),
              ),
            ],
          ).paddingOnly(top: 5.h),
          CommonCartButton(
            count: getIsSubCatModel()
                ? (homeDetailsWatch.subCatList?.subCatCartCount ?? 0)
                : (homeDetailsWatch.categoryList?.catCartCount ?? 0),
            onLikeTap: () => homeDetailsWatch.updateLikesCount(),
            onMinusTap: () => homeDetailsWatch.updateRemoveCount(),
            onAddTap: () => homeDetailsWatch.updateAddCount(),
          ).paddingOnly(top: 30.h).alignAtCenterRight()
        ],
      ).paddingAll(16.h),
    );
  }
}
