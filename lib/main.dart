import 'package:coffee_order/models/user.dart';
import 'package:coffee_order/screens/home.dart';
import 'package:coffee_order/screens/products/products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final user = User();

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'Coffee Order',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark
      ),
      home: FutureBuilder(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data ? MyHomePage(title: 'Bem vindo') : ProductsPage(userName: user.name);
          }

          return Center(child: CircularProgressIndicator());
        }
      ),
    );
  }

  Future<bool> _isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user.name = preferences.getString('user');
    return user == null;
  }
}