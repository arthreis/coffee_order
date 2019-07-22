import 'dart:async';
import 'dart:convert';

import 'package:coffee_order/models/order.dart';
import 'package:coffee_order/models/product.dart';
import 'package:http/http.dart' as http;

class Api {
//   static const String BASE_URL = "http://api-coffee-order.herokuapp.com/";
  static const String BASE_URL = "http://localhost:3000/";
  static const String COFFEES_URL = BASE_URL + "product/coffees";

  Future<List<Product>> getCoffees() async {
    var response = await http.get(COFFEES_URL).catchError((error) {
      print(error);
    });
    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Product>((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("ERROR");
    }
  }

  Future<void> saveOrder(Order order) async {
    await http
        .post(COFFEES_URL, body: json.encode(order.toJson()))
        .catchError((error) => print(error));
  }
}
