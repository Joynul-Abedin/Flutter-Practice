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
    databaseInit();
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
    final db = await database;
    await db.insert(
      'photos',
      productDataModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  void InsertData() async{
    final groceryData = groceryProducts;
    for (final product in groceryData) {
      await insertPhotos(ProductDataModel.fromMap(product));
    }
  }
}

// class GroceryData {
//   static List<Map<String, dynamic>> groceryProducts = [];
//
//   Future<void> fetchPhotos() async {
//     final url = Uri.https('makeup-api.herokuapp.com', '/api/v1/products.json',
//         {'brand': 'marienatie'});
//     final response = await http.get(url);
//     final List<dynamic> data = json.decode(response.body);
//     if (data is List && data.isNotEmpty) {
//       for (final product in data) {
//         if (product is Map<String, dynamic>) {
//           groceryProducts.add(product);
//         } else {
//           throw Exception('Invalid JSON data format');
//         }
//       }
//     } else {
//       throw Exception('Failed to load photos');
//     }
//   }
// }
