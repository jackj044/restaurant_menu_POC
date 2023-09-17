import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_menu_poc/framework/repository/home/model/menu_list_response_model.dart';
import 'package:restaurant_menu_poc/framework/utility/session.dart';
import 'package:restaurant_menu_poc/framework/utility/ui_state.dart';

final homeDetailsController = ChangeNotifierProvider((ref) => HomeDetailsController());

class HomeDetailsController extends ChangeNotifier {
  int selectedTab = 0;

  CategoryList? categoryList;
  SubCatList? subCatList;

  String? selectedFilter;

  /// update Tab Index
  void updateTabIndex(int index) {
    selectedTab = index;
    notifyListeners();
  }

  /// Update Likes Count
  void updateLikesCount() {

    if (categoryList != null) {
      categoryList?.catLikesStatus = !(categoryList?.catLikesStatus ?? false);
      // print(categoryList?.catLikesStatus = !(categoryList?.catLikesStatus ?? false));
    } else {
      subCatList?.subCatLikesStatus = !(subCatList?.subCatLikesStatus ?? false);
    }
    notifyListeners();
  }

  /// Update Add Count
  void updateAddCount() {
    if (categoryList != null) {
      if ((categoryList?.catCartCount ?? 0) < 30) {
        categoryList?.catCartCount = (categoryList?.catCartCount ?? 0) + 1;
      }
    } else {
      if ((subCatList?.subCatCartCount ?? 0) < 30) {
        subCatList?.subCatCartCount = (subCatList?.subCatCartCount ?? 0) + 1;
      }
    }
    notifyListeners();
  }

  /// Update Remove Count
  void updateRemoveCount() {
    if (categoryList != null) {
      if ((categoryList?.catCartCount ?? 0) > 0) {
        categoryList?.catCartCount = (categoryList?.catCartCount ?? 1) - 1;
      }
    } else {
      if ((subCatList?.subCatCartCount ?? 0) > 0) {
        subCatList?.subCatCartCount = (subCatList?.subCatCartCount ?? 1) - 1;
      }
    }
    notifyListeners();
  }

  /// Update Filter
  void updateFilter(String name) {
    selectedFilter = name;

    /// Get filter names
    List<String?>? nameList = subCatList?.subCatDetails?.map((element) => element.name).toList();

    /// Get Index of same name
    int? nameIndex = nameList?.indexOf(name);

    /// Update Index
    subCatList?.subCatSelectedindex = nameIndex;
    notifyListeners();
  }

  /// Get Data Locally
  getCatData() {
    String getCatRes = Session.getCategoryDetails();

    if (Session.getIsCatRes()) {
      categoryList = categoryListModelFromJson(getCatRes);
    } else {
      subCatList = subCategoryListFromJson(getCatRes);
    }
    notifyListeners();
  }

  /// Dispose Controller
  void disposeController() {
    isLoading = false;
    selectedTab = 0;
    categoryList = null;
    subCatList = null;
    selectedFilter = null;
    notifyListeners();
  }

  ///------------------------------ Load JSON ------------------------------///

  bool isLoading = false;

  UIState<MenuListResponseModel> menuModelState = UIState<MenuListResponseModel>();

  /// Update Is Loading
  void updateIsLoading(bool isLoad) {
    isLoading = isLoad;
    notifyListeners();
  }
}
