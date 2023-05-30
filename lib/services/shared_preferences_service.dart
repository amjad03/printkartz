import 'package:flutter/foundation.dart';
import 'package:Printzkart/widgets/show_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class FavoritesManager with ChangeNotifier{
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // SharedPreferences prefs = await SharedPreferences.getInstance();

  }

  // static Future<void> saveToFavorite(favoriteJson) async {
  //   // String favoriteJson = jsonEncode(favorite);
  //   await _prefs.setString('favorite', favoriteJson);
  //   showToast("Saved to Favorites");
  // }
  //
  // static Future<void> saveToFavorite2(newItem) async {
  //   final favoriteJson = _prefs.getString('favorite');
  //   Map<String, dynamic> favoriteList = {};
  //
  //   if (favoriteJson != null) {
  //     favoriteList = jsonDecode(favoriteJson);
  //   }
  //
  //   favoriteList.addAll(newItem);
  //
  //   final updatedFavoriteJson = jsonEncode(favoriteList);
  //   await _prefs.setString('favorite', updatedFavoriteJson);
  //   showToast("Saved to Favorites");
  // }


  //--------------------------------------------------------------------//

  static Future<void> saveToFavorites(newItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJsonList = prefs.getStringList('favorites') ?? [];

    bool isDuplicate = false;
    for (String itemJson in itemsJsonList) {
      final item = jsonDecode(itemJson);
      if (item['name'] == newItem['name']) {
        isDuplicate = true;
        break;
      }
    }

    if (!isDuplicate) {
      itemsJsonList.add(jsonEncode(newItem));
      prefs.setStringList('favorites', itemsJsonList);
      showToast("Added to Favorites");
      FavoritesManager favoritesManager = FavoritesManager();
      favoritesManager.notifyListeners();
    }
    if(isDuplicate){
      showToast("Already added");
    }
  }

  static Future<void> removeFromFavorites(itemToRemove) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJsonList = prefs.getStringList('favorites') ?? [];

    bool isFound = false;
    for (int i = 0; i < itemsJsonList.length; i++) {
      final item = jsonDecode(itemsJsonList[i]);
      if (item['name'] == itemToRemove['name']) {
        itemsJsonList.removeAt(i);
        isFound = true;
        break;
      }
    }

    if (isFound) {
      prefs.setStringList('favorites', itemsJsonList);
      showToast("Removed from Favorites");
      FavoritesManager favoritesManager = FavoritesManager();
      favoritesManager.notifyListeners();
    } else {
      showToast("Item not found in Favorites");
    }
  }


  static Future<List> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemJsonList = prefs.getStringList('favorites');
    if (itemJsonList == null) {
      showToast("No Wallpapers found");
      return [];
    }
    List itemList = itemJsonList.map((itemJson) => jsonDecode(itemJson)).toList();
    return itemList;
  }

  static Stream<List>  getFavoritesStream() {
    return getFavorites().asStream();
  }


  static bool checkIfFavoriteExists(itemToCheck) {
    List<String> itemsJsonList = _prefs.getStringList('favorites') ?? [];

    for (String itemJson in itemsJsonList) {
      final item = jsonDecode(itemJson);
      if (item['name'] == itemToCheck) {
        return true;
      }
    }

    return false;
  }

  static Map<dynamic, dynamic> getFavorite() {
    final favoriteJson = _prefs.getString('favorite');
    print(favoriteJson);
    return jsonDecode(favoriteJson!);
  }

  static Map<dynamic, dynamic> getFavorite2() {
    final favoriteJson = _prefs.getString('favorite');
    if (favoriteJson != null) {
      final favoriteList = jsonDecode(favoriteJson);
      return favoriteList;
    } else {
      return {};
    }
  }

}
