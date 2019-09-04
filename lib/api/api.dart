import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:coffee_order/models/order.dart';
import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/models/user.dart';
import 'package:http/http.dart' as http;

class Api {
//   static const String BASE_URL = "http://api-coffee-order.herokuapp.com/";
  static const String BASE_URL = "http://192.168.1.7:3000/";
  static const String COFFEES_URL = BASE_URL + "product/coffees/";
  static const String USER_URL = BASE_URL + "users/";

  Future<List<Product>> getCoffees() async {
    final response = await http.get(COFFEES_URL);

    if (response.statusCode == HttpStatus.ok) {
      return json.decode(response.body).map((json) => Product.fromJson(json)).cast<Product>().toList();
    }

    throw Exception('ERROR ${response.statusCode}');
  }

  Future<void> saveOrder(Order order) async {
    await http.post(COFFEES_URL, body: order.toJson());
  }

  Future<User> getUserById(String userId) async {
    Map headers = {
      'user-id': userId
    };

    final response = await http.get(USER_URL, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(json.decode(response.body));
    }
  
    throw Exception('ERROR ${response.statusCode}');
  }

  Future<User> getUserByEmail(String email) async {
    Map<String, String> headers = {
      'user-email': email
    };

    final response = await http.get(USER_URL, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(json.decode(response.body));
    }
    
    throw Exception('ERROR ${response.statusCode}');
  }

  Future<User> createUser(User user) async {
    final response = await http.post(USER_URL, body: user.toJson());
    
    if (response.statusCode == HttpStatus.ok) {
      return User.fromJson(json.decode(response.body));
    }
    
    throw Exception('ERROR ${response.statusCode}');
  }
}
