import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_menu_poc/framework/repository/home/model/menu_list_response_model.dart';
import 'package:restaurant_menu_poc/framework/utility/ui_state.dart';
import 'package:restaurant_menu_poc/ui/utils/const/app_constants.dart';
import 'package:restaurant_menu_poc/ui/utils/widgets/common_dialogs.dart';

final homeController = ChangeNotifierProvider((ref) => HomeController());

class HomeController extends ChangeNotifier {
  int selectedTab = 0;
  String? selectedFilter;

  /// update Tab Index
  void updateTabIndex(int index) {
    selectedTab = index;
    notifyListeners();
  }

  /// Update Filter
  void updateFilter(
    String name,
    SubCatList subCatList,
  ) {
    selectedFilter = name;

    /// Get filter names
    List<String?>? nameList = subCatList.subCatDetails?.map((element) => element.name).toList();

    /// Get Index of same name
    int? nameIndex = nameList?.indexOf(name);

    /// Update Index
    subCatList.subCatSelectedindex = nameIndex;
    notifyListeners();
  }

  /// Dispose Controller
  void disposeController() {
    isLoading = false;
    menuList.clear();
    selectedTab = 0;
    notifyListeners();
  }

  ///------------------------------ Load JSON ------------------------------///

  bool isLoading = false;

  UIState<MenuListResponseModel> menuModelState = UIState<MenuListResponseModel>();

  /// Tab List
  List<String?>? get tabList => menuModelState.success?.data?.map((element) => element.categoryName).toList();
  List<MenuModel> menuList = [];

  /// Update Is Loading
  void updateIsLoading(bool isLoad) {
    isLoading = isLoad;
    notifyListeners();
  }

  /// Update Pop Up Index
  void updatePopUpIndex(int index, int catIndex, SubCatDetail name) {
    /// Get Index of same item
    int? nameIndex = menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatDetails?.indexOf(name);

    /// Update Index
    menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatSelectedindex = nameIndex;
    notifyListeners();
  }

  /// Update Likes Count
  void updateLikesCount(int index, {int? catIndex}) {
    if (catIndex == null) {
      menuList[selectedTab].categoryList?[index].catLikesStatus = !(menuList[selectedTab].categoryList![index].catLikesStatus ?? false);
    } else {
      menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatLikesStatus = !(menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatLikesStatus ?? false);
    }
    notifyListeners();
  }

  /// Add To Cart
  void updateAddToCart(int index, {int? catIndex}) {
    if (catIndex == null) {
      if ((menuList[selectedTab].categoryList?[index].catCartCount ?? 0) < 30) {
        menuList[selectedTab].categoryList?[index].catCartCount =
            (menuList[selectedTab].categoryList?[index].catCartCount ?? 0) + 1;
      }
    } else {
      if ((menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatCartCount ?? 0) < 30) {
        menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatCartCount =
            (menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatCartCount ?? 0) + 1;
      }
    }

    notifyListeners();
  }

  /// Remove From Cart
  void updateRemoveFromCart(int index, {int? catIndex}) {
    if (catIndex == null) {
      if (menuList[selectedTab].categoryList?[index].catCartCount != 0) {
        menuList[selectedTab].categoryList?[index].catCartCount =
            (menuList[selectedTab].categoryList?[index].catCartCount ?? 1) - 1;
      }
    } else {
      if (menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatCartCount != 0) {
        menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatCartCount =
            (menuList[selectedTab].categoryList?[index].catList?[catIndex].subCatCartCount ?? 1) - 1;
      }
    }

    notifyListeners();
  }

  /// Get Menu Data
  Future<void> getMenuData(BuildContext context) async {
    try {
      menuModelState.isLoading = true;
      menuModelState.success = null;
      menuList.clear();
      notifyListeners();

      /// Load Static JSON using loadString
      final String response = await rootBundle.loadString('assets/json/menu.json');

      /// Parsing Response to model
      MenuListResponseModel menuListResponseModel = menuListResponseModelFromJson(response.toString());

      /// Check success and failure case
      if (menuListResponseModel.status == true) {
        menuModelState.success = menuListResponseModel;
        menuList.addAll(menuModelState.success?.data ?? []);
        menuModelState.isLoading = false;
      } else {
        if (context.mounted) {
          showMessageDialog(context, menuListResponseModel.message ?? '', () => null);
        }
      }
    } catch (e, stackTrace) {
      showLog('Error $e');
      showLog('StackTrace $stackTrace');
      menuModelState.isLoading = false;
    }
    notifyListeners();
  }
}
