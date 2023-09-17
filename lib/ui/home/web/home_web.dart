import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_menu_poc/framework/controller/home/home_controller.dart';
import 'package:restaurant_menu_poc/framework/controller/home_details/home_details_controller.dart';
import 'package:restaurant_menu_poc/framework/repository/home/model/menu_list_response_model.dart';
import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/framework/utility/session.dart';
import 'package:restaurant_menu_poc/ui/home/helper/cart_button.dart';
import 'package:restaurant_menu_poc/ui/home/helper/drawer.dart';
import 'package:restaurant_menu_poc/ui/home/helper/tab_bar_view.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/app_assets.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/app_colors.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/device_configuration.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/text_style.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/cache_image.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_appbar.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_dialogs.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_image_asset.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/empty_state_widget.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/slide_left_transition.dart';

class HomeWeb extends ConsumerStatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends ConsumerState<HomeWeb> {
  ///Init
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      final homeWatch = ref.watch(homeController);
      homeWatch.disposeController();
      await homeWatch.getMenuData(context);
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
    final homeWatch = ref.watch(homeController);
    webDeviceConfiguration(context);
    return Scaffold(
      backgroundColor: AppColors.primary.withOpacity(0.7),
      appBar: const CommonAppBar(
        isLeadingEnable: false,
        title: 'Menu',
        backgroundColor: AppColors.primary,
      ),
      body: homeWatch.menuList.isNotEmpty ? bodyWidget() : const Offstage(),
    );
  }

  /// Body Widget
  Widget bodyWidget() {
    final homeWatch = ref.watch(homeController);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: AppColors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Tab Bar
          SlideLeftTransition(
            delay: 100,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                // color: AppColors.primary,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                    gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                      AppColors.black.withOpacity(0.4),
                      AppColors.black.withOpacity(0.3),
                      AppColors.black.withOpacity(0.2),
                      AppColors.black.withOpacity(0.1),
                    ])),
                child: ListView(
                  children: [
                    //  CommonText(title: "MENU",
                    // textStyle: TextStyles.bold.copyWith(color: AppColors.black,fontSize: 25.sp),).alignAtCenter(),
                    CommonImageAsset(
                      strIcon: AppAssets.icSplash,
                      height: 145.h,
                      width: 135.w,
                      boxFit: BoxFit.contain,
                    ).alignAtCenter().paddingOnly(top: 20.h),
                    SizedBox(
                      height: 20.h,
                    ),
                    ...List.generate(
                      homeWatch.tabList?.length ?? 0,
                      (index) => InkWell(
                        onTap: () {
                          homeWatch.updateTabIndex(index);
                        },
                        child: DrawerView(title: homeWatch.tabList?[index] ?? '', isSelected: homeWatch.selectedTab == index),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),

          /// Tab View
          Expanded(
            child: SlideLeftTransition(
              delay: 150,
              child: Container(
                decoration: const BoxDecoration(
                    // color: AppColors.primary,
                    ),
                child: (homeWatch.menuList[homeWatch.selectedTab].categoryList?.isEmpty ?? false)
                    ? const EmptyStateWidget(emptyStateFor: EmptyState.noCatFound)
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeWatch.menuList[homeWatch.selectedTab].categoryList?.length,
                        itemBuilder: (context, index) {
                          /// For Category
                          if (homeWatch.menuList[homeWatch.selectedTab].isSubCategory == false) {
                            final menu = homeWatch.menuList[homeWatch.selectedTab].categoryList;
                            return InkWell(
                              onTap: () async {
                                await Session.userBox.delete(keyCategoryDetails);
                                await Session.userBox.delete(keyIsCatRes);
                                Session.saveLocalData(keyCategoryDetails, categoryListModelToJson(menu![index]));
                                Session.saveLocalData(keyIsCatRes, true);

                                final homeDetailsWatch = ref.watch(homeDetailsController);
                                homeDetailsWatch.disposeController();
                                await homeDetailsWatch.getCatData();

                                /// Navigate to details screen
                                /// Navigate to details screen
                                if (mounted) {
                                  showCommonWidgetDialog(context, homeDetailsWeb(menu[index], null), () {});
                                }
                              },
                              child: TabBarWidget(
                                title: menu?[index].catName ?? '',
                                isForWeb: true,
                                description: menu?[index].catDesc ?? '',
                                count: menu?[index].catCartCount ?? 0,
                                image: menu?[index].catImage ?? '',
                                like: menu?[index].catLikesStatus ?? false,
                                price: menu?[index].catPrice ?? '',
                                index: index,
                                catIndex: -1,
                                onLikeTap: () {
                                  homeWatch.updateLikesCount(index);
                                },
                                onMinusTap: () {
                                  homeWatch.updateRemoveFromCart(index);
                                },
                                onAddTap: () {
                                  print('index $index');
                                  homeWatch.updateAddToCart(index);
                                },
                              ),
                            );
                          }

                          /// For Sub Category
                          else {
                            final menu = homeWatch.menuList[homeWatch.selectedTab].categoryList;
                            return (menu?[index].catList?.isNotEmpty ?? false)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CommonText(
                                            title: menu?[index].catName ?? '',
                                            textStyle: TextStyles.semiBold.copyWith(fontSize: 26.sp, color: AppColors.black),
                                          ).paddingOnly(left: 16.w),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ...List.generate(
                                        menu?[index].catList?.length ?? 0,
                                        (i) {
                                          return InkWell(
                                            onTap: () async {
                                              await Session.userBox.delete(keyCategoryDetails);
                                              await Session.userBox.delete(keyIsCatRes);
                                              Session.saveLocalData(
                                                  keyCategoryDetails, subCategoryListToJson(menu![index].catList![i]));
                                              Session.saveLocalData(keyIsCatRes, false);

                                              final homeDetailsWatch = ref.watch(homeDetailsController);
                                              homeDetailsWatch.disposeController();
                                              await homeDetailsWatch.getCatData();

                                              /// Navigate to details screen
                                              if (mounted) {
                                                showCommonWidgetDialog(
                                                    context, homeDetailsWeb(null, menu[index].catList![i]), () {});
                                              }
                                            },
                                            child: TabBarWidget(
                                              title: menu?[index].catList?[i].subCatName ?? '',
                                              description: menu?[index].catList?[i].subCatDesc ?? '',
                                              count: menu?[index].catList?[i].subCatCartCount ?? 0,
                                              image: menu?[index].catList?[i].subCatImage ?? '',
                                              like: menu?[index].catList?[i].subCatLikesStatus ?? false,
                                              isForWeb: true,
                                              price: (menu?[index].catList?[i].subCatDetails?.isNotEmpty ?? false)
                                                  ? (menu?[index]
                                                          .catList?[i]
                                                          .subCatDetails?[menu[index].catList?[i].subCatSelectedindex ?? 0]
                                                          .price ??
                                                      '')
                                                  : menu?[index].catList?[i].subCatPrice ?? '',
                                              index: index,
                                              isFromWeb: true,
                                              catIndex: i,
                                              onLikeTap: () {
                                                /// Likes
                                                homeWatch.updateLikesCount(index, catIndex: i);
                                              },
                                              onMinusTap: () {
                                                /// Remove Cart
                                                homeWatch.updateRemoveFromCart(index, catIndex: i);
                                              },
                                              onAddTap: () {
                                                /// Add Cart
                                                homeWatch.updateAddToCart(index, catIndex: i);
                                              },
                                              isPopUpEnabled: true,
                                              subCatDetail: menu?[index].catList?[i].subCatDetails,
                                              onChange: (name) {
                                                homeWatch.updatePopUpIndex(index, i, name);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : const Offstage();
                          }
                        },
                      ).paddingOnly(top: 20.h),
              ),
            ),
          )
        ],
      ),
    ).paddingSymmetric(horizontal: 20..w, vertical: 20.h);
  }

  homeDetailsWeb(CategoryList? menu, SubCatList? catList) {
    webDeviceConfiguration(context);

    return homeDetails(menu, catList);
  }

  /// Check Whether Sub categories are there or not
  bool getIsSubCatModel(SubCatList? subCatList) {
    return subCatList != null;
  }

  /// Body Widget
  Widget homeDetails(CategoryList? categoryList, SubCatList? subCatList) {
    return Consumer(builder: (context, ref, child) {
      final homeDetailsWatch = ref.watch(homeDetailsController);
      return SizedBox(
        width: 500.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CacheImage(
                imageURL: getIsSubCatModel(subCatList) ? (subCatList?.subCatImage ?? '') : (categoryList?.catImage ?? ''),
                height: 350.h,
                width: MediaQuery.sizeOf(context).width,
                topRightRadius: 10,
                topLeftRadius: 10,
                bottomLeftRadius: 10,
                bottomRightRadius: 10,
                contentMode: BoxFit.cover,
              ).alignAtCenter(),
            ),
            Row(
              children: [
                Expanded(
                  child: CommonText(
                    title: getIsSubCatModel(subCatList) ? (subCatList?.subCatName ?? '') : (categoryList?.catName ?? ''),
                    textStyle: TextStyles.semiBold.copyWith(fontSize: 22.sp, color: AppColors.black),
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
                        child: getIsSubCatModel(subCatList)
                            ? Icon(
                                homeDetailsWatch.subCatList?.subCatLikesStatus == false ? Icons.favorite_border : Icons.favorite,
                                color: subCatList?.subCatLikesStatus != false ? AppColors.clrRedAccent : AppColors.clrRedAccent,
                              )
                            : Icon(
                                homeDetailsWatch.categoryList?.catLikesStatus == true ? Icons.favorite_border : Icons.favorite,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: CommonText(
                    title: getIsSubCatModel(subCatList) ? (subCatList?.subCatDesc ?? '') : (categoryList?.catDesc ?? ''),
                    textStyle: TextStyles.regular.copyWith(fontSize: 18.sp, color: AppColors.black.withOpacity(0.4)),
                    maxLines: 4,
                  ),
                ),
                const Spacer(),
                CommonText(
                  title: getIsSubCatModel(subCatList)
                      ? ('\$${subCatList?.subCatDetails?[subCatList.subCatSelectedindex ?? 0].price ?? ''}')
                      : ('\$${categoryList?.catPrice ?? ''}'),
                  textStyle: TextStyles.medium.copyWith(fontSize: 18.sp, color: AppColors.black),
                ),
              ],
            ).paddingOnly(top: 5.h),
            CommonCartButton(
              count: getIsSubCatModel(subCatList)
                  ? (homeDetailsWatch.subCatList?.subCatCartCount ?? 0)
                  : (homeDetailsWatch.categoryList?.catCartCount ?? 0),
              onLikeTap: () {
                homeDetailsWatch.updateLikesCount();
              },
              onMinusTap: () {
                homeDetailsWatch.updateRemoveCount();
              },
              onAddTap: () {
                homeDetailsWatch.updateAddCount();
              },
            ).paddingOnly(top: 30.h).alignAtCenterRight()
          ],
        ).paddingAll(16.h),
      );
    });
  }
}
