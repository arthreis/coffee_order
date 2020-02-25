import 'package:coffee_order/screen/login_page.dart';
import 'package:coffee_order/screen/products_page.dart';
import 'package:coffee_order/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModel>(
      create: (_) => UserModel(),
      child: MaterialApp(
        title: 'Coffee Order',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.amber,
          accentColor: Colors.amberAccent,
        ),
        home: Consumer<UserModel>(builder: (context, userModel, child) {
          if (userModel.loading) {
            return Container(
                constraints: BoxConstraints.expand(),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(child: CircularProgressIndicator()));
          }
          return userModel.user != null
              ? ProductsPage(userName: userModel.user.displayName)
              : LoginPage();
        }),
      ),
    );
  }
}
