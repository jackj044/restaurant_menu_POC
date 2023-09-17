import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_menu_poc/framework/controller/home/home_controller.dart';
import 'package:restaurant_menu_poc/framework/repository/home/model/menu_list_response_model.dart';
import 'package:restaurant_menu_poc/framework/utility/extension/extension.dart';
import 'package:restaurant_menu_poc/ui/home/helper/cart_button.dart';
import 'package:restaurant_menu_poc/ui/utils/theme/theme.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/cache_image.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_text.dart';

/// Tab Design
class TabBarWidget extends ConsumerWidget {
  final String title;
  final String description;
  final String image;
  final String price;
  final bool like;
  final int count;
  final int index;
  final int catIndex;
  final Function() onLikeTap;
  final Function() onMinusTap;
  final Function() onAddTap;
  final bool isForWeb;
  final Function(SubCatDetail name)? onChange;
  final bool isPopUpEnabled;
  final List<SubCatDetail>? subCatDetail;
  final bool isFromWeb;

  const TabBarWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.like,
    required this.count,
    required this.index,
    required this.onLikeTap,
    required this.onMinusTap,
    required this.onAddTap,
    this.subCatDetail,
    required this.catIndex,
    this.onChange,
    this.isForWeb = false,
    this.isPopUpEnabled = false,
    this.isFromWeb = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeWatch = ref.watch(homeController);
    int getIndexForCatView;
    if (catIndex == -1) {
      getIndexForCatView = index;
    } else {
      getIndexForCatView = catIndex;
    }
    return Container(
      margin: EdgeInsets.all(10.h),
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primary.withOpacity(0.09),
          border: Border.all(
            color: AppColors.black,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Image
          getIndexForCatView % 2 == 0
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CacheImage(
                        imageURL: image,
                        height: isForWeb ? 200.h : 100.h,
                        width: isForWeb ? 200.h : 100.h,
                        contentMode: BoxFit.fitHeight,
                      ),
                    ).paddingOnly(bottom: 15.h),
                    Positioned(
                      left: 10.w,
                      right: 10.w,
                      bottom: 0.h,
                      child: CommonCartButton(
                        count: count,
                        onLikeTap: () {
                          onLikeTap();
                        },
                        onMinusTap: () {
                          onMinusTap();
                        },
                        onAddTap: () {
                          onAddTap();
                        },
                      ),
                    )
                  ],
                ).paddingOnly(right: 20.w)
              : const Offstage(),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CommonText(
                        title: title,
                        textStyle: TextStyles.medium.copyWith(
                          fontSize: isForWeb ? 22.sp : 14.sp,
                          color: AppColors.black,
                        ),
                        maxLines: 4,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Visibility(
                      visible: catIndex != -1 &&
                          (homeWatch.menuList[homeWatch.selectedTab].categoryList?[index].catList?[catIndex].subCatDetails
                                  ?.isNotEmpty ??
                              false),
                      child: SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              ...List.generate(
                                (homeWatch.menuList[homeWatch.selectedTab].categoryList?[index].catList?[catIndex].subCatDetails
                                        ?.length ??
                                    0),
                                (getIndex) {
                                  final item = homeWatch.menuList[homeWatch.selectedTab].categoryList?[index].catList?[catIndex]
                                      .subCatDetails?[getIndex];
                                  return PopupMenuItem(
                                    onTap: () {
                                      homeWatch.updateFilter(item?.name ?? '',
                                          (homeWatch.menuList[homeWatch.selectedTab].categoryList![index].catList![catIndex]));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: CommonText(
                                            title: item?.name ?? '',
                                            maxLines: 4,
                                            textStyle: item?.name == homeWatch.selectedFilter
                                                ? TextStyles.bold.copyWith(fontSize: 14.sp, color: AppColors.primary)
                                                : TextStyles.regular.copyWith(fontSize: 14.sp, color: AppColors.black),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Visibility(
                                            visible: item?.name == homeWatch.selectedFilter,
                                            child: FittedBox(
                                              child: Icon(
                                                Icons.check,
                                                size: 20.h,
                                                color: AppColors.black,
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                                },
                              )
                            ];
                          },
                          onSelected: (String value) {
                            homeWatch.updateFilter(
                                value, (homeWatch.menuList[homeWatch.selectedTab].categoryList![index].catList![catIndex]));
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: AppColors.black,
                            size: 15.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                description != ''
                    ? CommonText(
                        title: description,
                        textStyle: TextStyles.regular.copyWith(
                          fontSize: isForWeb ? 20.sp : 12.sp,
                          color: AppColors.grey707070,
                        ),
                        maxLines: 10,
                      ).paddingOnly(top: 2.h)
                    : const Offstage(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonText(
                      title: '\$ $price',
                      textStyle: TextStyles.regular.copyWith(
                        fontSize: isForWeb ? 20.sp : 12.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    // isFromWeb
                    //     ? (subCatDetail?.isNotEmpty ?? false)
                    //         ? isPopUpEnabled
                    //             ? DropdownButtonHideUnderline(
                    //                 child: DropdownButton2<SubCatDetail>(
                    //                   isExpanded: true,
                    //                   isDense: true,
                    //                   hint: Text(
                    //                     'Select Item',
                    //                     style: TextStyle(
                    //                       fontSize: 14,
                    //                       color: Theme.of(context).hintColor,
                    //                     ),
                    //                   ),
                    //                   items: [
                    //                     // (subCatDetail?.map((e) => e.name).toList() ?? [])
                    //                     ...List.generate(
                    //                       (subCatDetail?.length ?? 0),
                    //                       (index) => DropdownMenuItem<SubCatDetail>(
                    //                         value: subCatDetail?[index],
                    //                         child: Padding(
                    //                           padding: EdgeInsets.symmetric(horizontal: 8.w),
                    //                           child: Text(
                    //                             subCatDetail?[index].name ?? '',
                    //                             style: TextStyle(
                    //                               fontSize: isForWeb ? 16.sp : 12.sp,
                    //                             ),
                    //                             maxLines: 2,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //
                    //                     //If it's last item, we will not add Divider after it.
                    //                   ],
                    //                   value: homeWatch.menuList[homeWatch.selectedTab].categoryList?[index].catList?[catIndex]
                    //                       .subCatDetails?[homeWatch.menuList[homeWatch.selectedTab].categoryList?[index]
                    //                           .catList?[catIndex].subCatSelectedindex ??
                    //                       0],
                    //                   onChanged: (SubCatDetail? value) {
                    //                     onChange!(value!);
                    //                   },
                    //                   buttonStyleData: isFromWeb
                    //                       ? ButtonStyleData(
                    //                           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    //                           height: 50,
                    //                           decoration: BoxDecoration(
                    //                             border: Border.all(color: AppColors.black),
                    //                           ),
                    //                           width: 500,
                    //                         )
                    //                       : ButtonStyleData(
                    //                           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    //                           height: 50,
                    //                           decoration: BoxDecoration(
                    //                             border: Border.all(color: AppColors.black),
                    //                           ),
                    //                         ),
                    //                   dropdownStyleData: const DropdownStyleData(
                    //                     maxHeight: 250,
                    //                   ),
                    //                   menuItemStyleData: const MenuItemStyleData(
                    //                     padding: EdgeInsets.zero,
                    //
                    //                     // customHeights: _getCustomItemsHeights(),
                    //                   ),
                    //                   iconStyleData: const IconStyleData(
                    //                     openMenuIcon: Icon(Icons.arrow_drop_up),
                    //                   ),
                    //                 ),
                    //               )
                    //             : const Offstage()
                    //         : const Offstage()
                    //     : const Offstage(),
                  ],
                ).paddingOnly(top: 4.h),
                ClipOval(
                  child: InkWell(
                    onTap: () {
                      onLikeTap();
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
                        child: Icon(
                          like == false ? Icons.favorite_border : Icons.favorite,
                          color: like != false ? AppColors.clrRedAccent : AppColors.clrRedAccent,
                        ),
                      ),
                    ),
                  ),
                ).paddingOnly(top: 10.h),
              ],
            ),
          ),

          /// Image
          getIndexForCatView % 2 != 0
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: CacheImage(
                        imageURL: image,
                        height: isForWeb ? 250.h : 100.h,
                        width: isForWeb ? 250.h : 100.h,
                        contentMode: BoxFit.fitHeight,
                      ),
                    ).paddingOnly(bottom: 15.h),
                    Positioned(
                      left: 10.w,
                      right: 10.w,
                      bottom: 0.h,
                      child: CommonCartButton(
                        count: count,
                        onLikeTap: () {
                          onLikeTap();
                        },
                        onMinusTap: () {
                          onMinusTap();
                        },
                        onAddTap: () {
                          onAddTap();
                        },
                      ),
                    )
                  ],
                ).paddingOnly(left: 20.w)
              : const Offstage(),
        ],
      ),
    );
  }
}
