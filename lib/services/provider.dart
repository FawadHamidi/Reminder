import 'package:flutter/material.dart';
import 'package:reminder/models/qoute_model.dart';
import 'package:reminder/models/wallpaper_model.dart';
import 'package:reminder/services/api_services.dart';
import 'package:reminder/services/database_helper.dart';

class ApiProvider extends ChangeNotifier {
  List<Quotes> quoteList;
  List<Quotes> queryList;
  List<WallpaperModel> wallpaperList;
  IconData icon;
  bool isLoading = false;

  loadQuotes() async {
    try {
      quoteList = await ApiServices().getQuotes();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  IconData updateFav(bool isFav) {
    if (isFav) {
      icon = Icons.favorite;
    } else
      icon = Icons.favorite_border;
    notifyListeners();
    return icon;
  }

  loadQueries() async {
    try {
      queryList = await ApiServices().getDatabaseQueries();
      notifyListeners();
      return queryList;
    } catch (e) {
      print(e);
    }
  }

  checkFavorites(int id) async {
    try {
      bool isFavorite = await DatabaseHelper().isFavourite(id);
      notifyListeners();
      return isFavorite;
    } catch (e) {
      print(e);
    }
  }

  loadWallpapers() async {
    try {
      wallpaperList = await ApiServices().getWallpapers();
      notifyListeners();
      print(wallpaperList.length);
      return wallpaperList;
    } catch (e) {
      print(e);
    }
  }

  deleteAllQueries() async {
    try {
      await DatabaseHelper().deleteAll();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
