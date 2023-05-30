import 'package:flutter/foundation.dart';
import 'package:printzkart/widgets/show_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// class FavoritesManager {
//   static late SharedPreferences _prefs;

  // Initialize shared preferences
  // Future<void> init() async {
  //   _prefs = await SharedPreferences.getInstance();
  // }
  //
  // static Future<void> saveList(String key, List<String> dataList) async {
  //   await _prefs.setStringList(key, dataList);
  // }
  //
  // // Add an item to favorites
  // Future<void> addToFavorites(String itemId) async {
  //   List<String> favorites = _prefs.getStringList('favorites') ?? [];
  //   favorites.add(itemId);
  //   await _prefs.setStringList('favorites', favorites);
  // }
  //
  // // Remove an item from favorites
  // Future<void> removeFromFavorites(String itemId) async {
  //   List<String> favorites = _prefs.getStringList('favorites') ?? [];
  //   favorites.remove(itemId);
  //   await _prefs.setStringList('favorites', favorites);
  // }
  //
  // // Check if an item is in favorites
  // bool isFavorite(String itemId) {
  //   List<String> favorites = _prefs.getStringList('favorites') ?? [];
  //   return favorites.contains(itemId);
  // }
  //
  // // Get all favorite items
  // List<String> getFavorites() {
  //   return _prefs.getStringList('favorites') ?? [];
  // }
// }

// import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager with ChangeNotifier{
  static late SharedPreferences _prefs;

  // Initialize shared preferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // SharedPreferences prefs = await SharedPreferences.getInstance();

  }

  // Save list of maps as favorites
  // static Future<void> saveFavorites(List<Map<dynamic, dynamic>> favorites) async {
  //   List<String> encodedFavorites = favorites.map((favorite) => favorite.toString()).toList();
  //   await _prefs.setStringList('favorites', encodedFavorites);
  // }

  static Future<void> saveToFavorite(favoriteJson) async {
    // String favoriteJson = jsonEncode(favorite);
    await _prefs.setString('favorite', favoriteJson);
    showToast("Saved to Favorites");
  }

  static Future<void> saveToFavorite2(newItem) async {
    final favoriteJson = _prefs.getString('favorite');
    Map<String, dynamic> favoriteList = {};

    if (favoriteJson != null) {
      favoriteList = jsonDecode(favoriteJson);
    }

    favoriteList.addAll(newItem);

    final updatedFavoriteJson = jsonEncode(favoriteList);
    await _prefs.setString('favorite', updatedFavoriteJson);
    showToast("Saved to Favorites");
  }


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

  // Retrieve list of favorites
  // static List<Map<String, dynamic>> getFavorites() {
  //   List<String> encodedFavorites = _prefs.getStringList('favorite') ?? [];
  //   List<Map<String, dynamic>> favorites = encodedFavorites
  //       .map((favorite) => jsonDecode(favorite) as Map<String, dynamic>)
  //       .toList();
  //   return favorites;
  // }
  // static List<Map<dynamic, dynamic>> getFavorites() {
  //   List<String>? encodedFavorites = _prefs.getStringList('favorite');
  //   List<Map<dynamic, dynamic>> favorites = encodedFavorites?.map((favorite) {
  //     return jsonDecode(favorite) as Map<dynamic, dynamic>;
  //   }).toList() ?? [];
  //   return favorites;
  // }

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




// static getFromFavorite() {
  //   // Map<String, dynamic> abc = null;
  //   String? favoriteJson = _prefs.getString('favorite');
  //   if (favoriteJson != null) {
  //     return favoriteJson;
  //   }
  //   return null;
  // }
  // static List<Map<String, dynamic>> getFavorites() {
  //   List<String> encodedFavorites = _prefs.getStringList('favorites') ?? [];
  //   List<Map<String, dynamic>> favorites = encodedFavorites.map((favorite) => Map<String, dynamic>.from(eval(favorite))).toList();
  //   return favorites;
  // }

  // Add a favorite item to the list
  // static Future<void> addFavorite(Map<dynamic, dynamic> favorite) async {
  //   List<Map<dynamic, dynamic>> favorites = getFavorites();
  //   favorites.add(favorite);
  //   await saveFavorites(favorites);
  //   print("\n\n Added to Favorites");
  // }
  //
  // // Remove a favorite item from the list
  // static Future<void> removeFavorite(String itemId) async {
  //   List<Map<dynamic, dynamic>> favorites = getFavorites();
  //   favorites.removeWhere((favorite) => favorite['id'] == itemId);
  //   await saveFavorites(favorites);
  // }
}
