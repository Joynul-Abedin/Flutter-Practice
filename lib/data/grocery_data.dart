import 'dart:convert';

import 'package:http/http.dart' as http;

class GroceryData {
  static List<Map<String, dynamic>> groceryProducts = [];

  Future<void> fetchPhotos() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/photos');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      groceryProducts =
          List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load photos');
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
