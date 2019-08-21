import 'dart:async';
import 'dart:convert';

import 'package:coffee_order/models/order.dart';
import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/models/user.dart';
import 'package:http/http.dart' as http;

class Api {
//   static const String BASE_URL = "http://api-coffee-order.herokuapp.com/";
  static const String BASE_URL = "http://localhost:3000/";
  static const String COFFEES_URL = BASE_URL + "product/coffees/";
  static const String USER_URL = BASE_URL + "users/";

  Future<List<Product>> getCoffees() async {
    var response = await http.get(COFFEES_URL).catchError((error) {
      print(error);
    });
    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("ERROR");
    }
  }

  Future<void> saveOrder(Order order) async {
    await http
        .post(COFFEES_URL, body: json.encode(order.toJson()))
        .catchError((error) => print(error));
  }

  Future<User> getUserById(String userId) async {
    var response = await http.get(USER_URL + '$userId').catchError((error) {
      print(error);
    });

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('ERROR ${response.statusCode}');
    }
  }

  Future<User> getUserByEmail(String email) async {
    var response =
        await http.get(USER_URL + 'email=$email').catchError((error) {
      print(error);
    });

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('ERROR ${response.statusCode}');
    }
  }

  Future<User> createUser(User user) async {
    var response = await http
        .post(USER_URL, body: json.encode(user.toJson()))
        .catchError((error) => print(error));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('ERROR ${response.statusCode}');
    }
  }
}
