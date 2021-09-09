import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class DatabaseHelper extends ChangeNotifier {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';

  // DatabaseHelper._privateConstructor();
  //
  // static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  //
  // factory DatabaseHelper() => _instance;

  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      // print('kami Null');

      return _database;
    } else {
      _database = await _initiateDatabase();

      return _database;
    }
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = Path.join(directory.path, _dbName);
    // print('kami initialize $path');
    notifyListeners();
    var myDB =
        await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
    // print('MyDB: ${myDB.isOpen}');
    return myDB;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
      id INTEGER PRIMARY KEY,
      quoteID INTEGER NOT NULL,
      quote TEXT NOT NULL,
      author TEXT NOT NULL
      )
      
     ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await database;
    notifyListeners();
    return await db.insert(_tableName, row);
  }

  Future<bool> isFavourite(int id) async {
    Database db = await database;
    var result = await db.rawQuery('''
      SELECT * FROM $_tableName WHERE quoteID = $id
      ''');
    if (result.length == 0 || result == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await database;
    notifyListeners();
    return await db.query(_tableName);
  }

  Future update(Map<String, dynamic> row, int id) async {
    Database db = await database;
    notifyListeners();
    return await db.update(_tableName, row, where: 'id= ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await database;
    notifyListeners();
    return await db.delete(_tableName, where: 'quoteID= ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    Database db = await database;
    await db.rawQuery("DELETE FROM $_tableName");
    notifyListeners();
  }
}
