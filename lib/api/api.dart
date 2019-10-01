import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:coffee_order/models/order.dart';
import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/models/user.dart';
import 'package:http/http.dart' as http;

class Api {
//   static const String BASE_URL = "http://api-coffee-order.herokuapp.com";
  static const String BASE_URL = "http://192.168.1.7:3000";
  static const String COFFEES_URL = BASE_URL + "/product/coffees";
  static const String USERS_URL = BASE_URL + "/users";
  static const String ORDERS_URL = BASE_URL + "/orders";

  /// Returns a list of all products currently stored at the database.
  Future<List<Product>> getCoffees() async {
    final response = await http.get(COFFEES_URL);

    if (response.statusCode == HttpStatus.ok) {
      return json.decode(response.body).map((json) => Product.fromJson(json)).cast<Product>().toList();
    }

    throw Exception('ERROR: ${response.statusCode}');
  }

  /// Stores [order] on database.
  Future<void> saveOrder(Order order) async {
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

    final response = await http.post(ORDERS_URL, body: json.encode(order), headers: headers);
    if (response.statusCode != HttpStatus.created) {
      throw Exception("ERROR: ${response.statusCode}");
    }
  }

  /// Looks for a user using [userId] as a search parameter.
  /// Returns null if no user is found.
  Future<User> getUserById(String userId) async {
    try {
      final response = await http.get(USERS_URL + '/$userId');

      if (response.statusCode == HttpStatus.ok) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('ERROR: ${response.statusCode}');
      }
    } catch(e) {
      print(e);
    }

    return null;
  }

  /// Looks for a user using [email] as a search parameter.
  /// Returns null if no user is found.
  Future<User> getUserByEmail(String email) async {
    try {
      final response = await http.get(USERS_URL + '?email=$email');
      
      if (response.statusCode == HttpStatus.ok) {
        final List<User> users = json.decode(response.body).map((json) => User.fromJson(json)).cast<User>().toList();
        return users.isNotEmpty ? users.first : null;
      } else {
        throw Exception('ERROR: ${response.statusCode}');
      }
    } catch(e) {
      print(e);
    }

    return null;
  }

  /// Stores [user] in the database.
  /// Returns null if the operation fails.
  Future<User> createUser(User user) async {
    try {
      final response = await http.post(USERS_URL, body: user.toJson());
    
      if (response.statusCode == HttpStatus.created) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('ERROR: ${response.statusCode}');
      }
    } catch(e) {
      print(e);
    }
    
    return null;
  }
}
