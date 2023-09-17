// To parse this JSON data, do
//
//     final menuListResponseModel = menuListResponseModelFromJson(jsonString);

import 'dart:convert';

MenuListResponseModel menuListResponseModelFromJson(String str) => MenuListResponseModel.fromJson(json.decode(str));

String menuListResponseModelToJson(MenuListResponseModel data) => json.encode(data.toJson());

/// From And To JSON For Category List
CategoryList categoryListModelFromJson(String str) => CategoryList.fromJson(json.decode(str));

String categoryListModelToJson(CategoryList data) => json.encode(data.toJson());

/// From And To JSON For Sub Category List
SubCatList subCategoryListFromJson(String str) => SubCatList.fromJson(json.decode(str));

String subCategoryListToJson(SubCatList data) => json.encode(data.toJson());

class MenuListResponseModel {
  bool? status;
  String? message;
  List<MenuModel>? data;

  MenuListResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory MenuListResponseModel.fromJson(Map<String, dynamic> json) => MenuListResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<MenuModel>.from(json["data"]!.map((x) => MenuModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MenuModel {
  String? categoryId;
  String? categoryName;
  String? categoryDesc;
  bool? isSubCategory;
  List<CategoryList>? categoryList;

  MenuModel({
    this.categoryId,
    this.categoryName,
    this.categoryDesc,
    this.isSubCategory,
    this.categoryList,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryDesc: json["category_desc"],
        isSubCategory: json["is_sub_category"],
        categoryList: json["category_list"] == null
            ? []
            : List<CategoryList>.from(json["category_list"]!.map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_desc": categoryDesc,
        "is_sub_category": isSubCategory,
        "category_list": categoryList == null ? [] : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
      };
}

class CategoryList {
  String? catId;
  String? catName;
  String? catDesc;
  String? catPrice;
  String? catImage;
  bool? catLikesStatus;
  int? catCartCount;
  List<SubCatList>? catList;
  int? selectedIndex;

  CategoryList({
    this.catId,
    this.catName,
    this.catDesc,
    this.catPrice,
    this.catImage,
    this.catLikesStatus,
    this.catCartCount,
    this.catList,
    this.selectedIndex,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        catId: json["cat_id"],
        catName: json["cat_name"],
        catDesc: json["cat_desc"],
        catPrice: json["cat_price"],
        catImage: json["cat_image"],
        catLikesStatus: json["cat_likes_status"],
        catCartCount: json["cat_cart_count"],
        selectedIndex: json["sub_cat_selected_index"],
        catList: json["cat_list"] == null ? [] : List<SubCatList>.from(json["cat_list"]!.map((x) => SubCatList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "cat_name": catName,
        "cat_desc": catDesc,
        "cat_price": catPrice,
        "cat_image": catImage,
        "cat_likes_status": catLikesStatus,
        "cat_cart_count": catCartCount,
        "sub_cat_selected_index": selectedIndex,
        "cat_list": catList == null ? [] : List<dynamic>.from(catList!.map((x) => x.toJson())),
      };
}

class SubCatList {
  String? subCatId;
  String? subCatName;
  String? subCatDesc;
  String? amountType;
  List<SubCatDetail>? subCatDetails;
  String? subCatImage;
  bool? subCatLikesStatus;
  int? subCatCartCount;
  String? subCatPrice;
  int? subCatSelectedindex;

  SubCatList({
    this.subCatId,
    this.subCatName,
    this.subCatDesc,
    this.amountType,
    this.subCatDetails,
    this.subCatImage,
    this.subCatLikesStatus,
    this.subCatCartCount,
    this.subCatPrice,
    this.subCatSelectedindex,
  });

  factory SubCatList.fromJson(Map<String, dynamic> json) => SubCatList(
        subCatId: json["sub_cat_id"],
        subCatName: json["sub_cat_name"],
        subCatDesc: json["sub_cat_desc"],
        amountType: json["amount_type"],
        subCatDetails: json["sub_cat_details"] == null
            ? []
            : List<SubCatDetail>.from(json["sub_cat_details"]!.map((x) => SubCatDetail.fromJson(x))),
        subCatImage: json["sub_cat_image"],
        subCatLikesStatus: json["cat_likes_status"],
        subCatCartCount: json["sub_cat_cart_count"],
        subCatPrice: json["sub_cat_price"],
        subCatSelectedindex: json["sub_cat_selected_index"],
      );

  Map<String, dynamic> toJson() => {
        "sub_cat_id": subCatId,
        "sub_cat_name": subCatName,
        "sub_cat_desc": subCatDesc,
        "amount_type": amountType,
        "sub_cat_details": subCatDetails == null ? [] : List<dynamic>.from(subCatDetails!.map((x) => x.toJson())),
        "sub_cat_image": subCatImage,
        "cat_likes_status": subCatLikesStatus,
        "sub_cat_cart_count": subCatCartCount,
        "sub_cat_price": subCatPrice,
        "sub_cat_selected_index": subCatSelectedindex,
      };
}

class SubCatDetail {
  String? id;
  String? name;
  String? price;

  SubCatDetail({
    this.id,
    this.name,
    this.price,
  });

  factory SubCatDetail.fromJson(Map<String, dynamic> json) => SubCatDetail(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
