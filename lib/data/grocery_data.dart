import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../features/home/models/home_product_data_model.dart';

class GroceryData {
  static List<Map<String, dynamic>> groceryProducts = [];
  static late Future<Database> database;

  void databaseInit() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE photos(albumId INTEGER, id INTEGER PRIMARY KEY,  title TEXT, thumbnailUrl TEXT, url TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> fetchPhotos() async {
    databaseInit(); // Initialize the database first
    final url = Uri.https('jsonplaceholder.typicode.com', '/photos');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      groceryProducts =
      List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<void> insertPhotos(ProductDataModel productDataModel) async {
    databaseInit(); // Initialize the database first
    final db = await database;
    await db.insert(
      'photos',
      productDataModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void insertData() async {
    databaseInit(); // Initialize the database first
    final groceryData = groceryProducts;
    for (final product in groceryData) {
      await insertPhotos(ProductDataModel.fromMap(product));
    }
  }
}

