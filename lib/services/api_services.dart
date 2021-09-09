import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:reminder/models/qoute_model.dart';
import 'package:reminder/models/wallpaper_model.dart';
import 'package:reminder/services/database_helper.dart';
import 'package:reminder/services/service_locator.dart';

class ApiServices {
  List<WallpaperModel> wallpapers = [];
  Dio _dio = Dio();
  final String baseUrl = 'https://type.fit/api/quotes';
  final String apiKey =
      '563492ad6f9170000100000109811b1472354c21a0869f828ce0907f';
  // Future<List<WallpaperModel>> getCategoryPhotos() async {
  //   final response = await _dio.get(
  //     "https://api.pexels.com/v1/search?query=Nature&per_page=500",
  //     options: Options(headers: {"Authorization": apiKey}),
  //   );
  //
  //   print(response.data);
  //
  //   Map<String, dynamic> jsonData = jsonDecode(response.data);
  //   jsonData['photos'].forEach((element) {
  //     List<WallpaperModel> wallpaperModel = WallpaperModel();
  //     wallpaperModel = WallpaperModel.fromJson(element);
  //     wallpapers.add(wallpaperModel);
  //   });
  // }

  Future<List<WallpaperModel>> getWallpapers() async {
    try {
      final response = await _dio.get(
        'https://api.pexels.com/v1/search?query=Nature&per_page=500',
        options: Options(headers: {"Authorization": apiKey}),
      );
      // print(response.data);
      var wallpapers = response.data['photos'] as List;
      List<WallpaperModel> wallpaperList =
          wallpapers.map((e) => WallpaperModel.fromJson(e)).toList();
      // print(wallpaperList.length);
      return wallpaperList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Quotes>> getQuotes() async {
    try {
      final response = await _dio.get('$baseUrl');
      var quotes = json.decode(response.data);
      List<Quotes> quoteList = [];
      int id = 0;
      for (Map quote in quotes) {
        quoteList.add(Quotes.fromJson({
          "text": quote['text'],
          "author": quote['author'],
          "id": id++,
        }));
      }

      // List<Quotes> quoteList =
      //     (quotes as List).map((e) => Quotes.fromJson(e)).toList();
      // print(quoteList.length);
      return quoteList;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }

  Future<List<Quotes>> getDatabaseQueries() async {
    try {
      List<Map> queries = await locator<DatabaseHelper>().queryAll();
      List<Quotes> quotes = queries
          .map((e) => Quotes.fromJson(
              {'text': e['quote'], 'id': e['quoteID'], 'author': e['author']}))
          .toList();
      // print(quotes[0].author);
      return quotes;
    } catch (error, stacktrace) {
      print(error);
      throw Exception('Exception occure:$error with stacktrace:$stacktrace');
    }
  }
}
