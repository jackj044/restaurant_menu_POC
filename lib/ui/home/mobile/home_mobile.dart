import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_menu_poc/framework/controller/home/home_controller.dart';
import 'package:restaurant_menu_poc/framework/repository/home/model/menu_list_response_model.dart';
import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/framework/utility/session.dart';
import 'package:restaurant_menu_poc/ui/home/helper/tab_bar_view.dart';
import 'package:restaurant_menu_poc/ui/home/helper/tab_view.dart';
import 'package:restaurant_menu_poc/ui/routing/navigation_stack_item.dart';
import 'package:restaurant_menu_poc/ui/routing/stack.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/device_configuration.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_appbar.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/empty_state_widget.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/slide_left_transition.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeMobile extends ConsumerStatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends ConsumerState<HomeMobile> {
  /// Page Controller
  PageController controller = PageController();

  ItemScrollController scrollController = ItemScrollController();

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
    mobileDeviceConfiguration(context);
    final homeWatch = ref.watch(homeController);
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Menu',
        backgroundColor: AppColors.primary,
        isLeadingEnable: false,
      ),
      body: homeWatch.menuList.isNotEmpty ? bodyWidget() : const Offstage(),
    );
  }

  /// Body Widget
  Widget bodyWidget() {
    final homeWatch = ref.watch(homeController);
    return Column(
      children: [
        /// Tab List
        SlideLeftTransition(
          delay: 100,
          child: SizedBox(
            height: 50.h,
            width: MediaQuery.sizeOf(context).width,
            child: ScrollablePositionedList.builder(
              itemScrollController: scrollController,
              itemCount: homeWatch.tabList?.length ?? 0,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    homeWatch.updateTabIndex(index);
                  },
                  child: TabView(tabName: homeWatch.tabList?[index] ?? '', isSelected: homeWatch.selectedTab == index),
                );
              },
            ),
          ).paddingOnly(top: 20.h),
        ),

        /// Tab View
        Expanded(
          child: PageView.builder(
            itemCount: homeWatch.tabList?.length ?? 0,
            controller: controller,
            onPageChanged: (index) {
              scrollController.scrollTo(index: index, duration: const Duration(seconds: 1));
              homeWatch.updateTabIndex(index);
            },
            itemBuilder: (context, index) {
              return SlideLeftTransition(
                delay: 150,
                child: (homeWatch.menuList[homeWatch.selectedTab].categoryList?.isEmpty ?? false)
                    ? const EmptyStateWidget(emptyStateFor: EmptyState.noCatFound)
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeWatch.menuList[homeWatch.selectedTab].categoryList?.length,
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
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

                                /// Navigate to details screen
                                ref.read(navigationStackController).push(const NavigationStackItem.homeDetails());
                              },
                              child: TabBarWidget(
                                title: menu?[index].catName ?? '',
                                description: menu?[index].catDesc ?? '',
                                count: menu?[index].catCartCount ?? 0,
                                image: menu?[index].catImage ?? '',
                                like: (menu?[index].catLikesStatus ?? false),
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
                                    children: [
                                      Row(
                                        children: [
                                          CommonText(
                                            title: menu?[index].catName ?? '',
                                            textStyle: TextStyles.semiBold.copyWith(fontSize: 18.sp, color: AppColors.black),
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

                                              /// Navigate to details screen
                                              ref.read(navigationStackController).push(const NavigationStackItem.homeDetails());
                                            },
                                            child: TabBarWidget(
                                              title: menu?[index].catList?[i].subCatName ?? '',
                                              description: menu?[index].catList?[i].subCatDesc ?? '',
                                              count: menu?[index].catList?[i].subCatCartCount ?? 0,
                                              image: menu?[index].catList?[i].subCatImage ?? '',
                                              like: menu?[index].catList?[i].subCatLikesStatus ?? false,
                                              price: (menu?[index].catList?[i].subCatDetails?.isNotEmpty ?? false)
                                                  ? (menu?[index]
                                                          .catList?[i]
                                                          .subCatDetails?[menu[index].catList?[i].subCatSelectedindex ?? 0]
                                                          .price ??
                                                      '')
                                                  : menu?[index].catList?[i].subCatPrice ?? '',
                                              index: index,
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
                      ).paddingOnly(top: 10.h,bottom: 20.h),
              );
            },
          ),
        ),

        /// Tab Bar View
        // Expanded(
        //   child: ,
        // )
      ],
    );
  }
}
