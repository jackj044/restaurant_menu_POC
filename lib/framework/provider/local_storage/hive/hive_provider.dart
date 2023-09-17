import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_menu_poc/framework/provider/local_storage/local_const.dart';

/// Static Methods related to  hive provider
/// CRUD operation


class HiveProvider{

  static Box? appBox;

  static Future<bool> init() async {
    await Hive.initFlutter();
    await Hive.openBox(LocalConst.appBox);
    appBox = Hive.box(LocalConst.appBox);
    return true;
  }


  /// Add value in key value pair
  static Future<bool> add(dynamic key,dynamic value) async {
   try{
     await appBox!.put(key, value);
     return true;
   }
   catch(e)
    {
      return false;
    }

  }

  /// get value in key value pair
  /// Return null if data not found
  static Future<dynamic> get(dynamic key) async {
    try{
      return await appBox!.get(key);
    }
    catch(e)
    {
      return e;
    }

  }

  /// update value by key
  static Future<bool> update(dynamic key,dynamic value) async {
    try{
      await appBox!.put(key, value);
      return true;
    }
    catch(e)
    {
      return false;
    }

  }

  /// delete value by key
  static Future<bool> delete(dynamic key) async {
    try{
      await appBox!.delete(key);
      return true;
    }
    catch(e)
    {
      return false;
    }

  }




}
