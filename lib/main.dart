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
          applyElevationOverlayColor: true,
          brightness: Brightness.dark,
          accentColor: Colors.lime.shade300,
          primaryColor: Color(0xff121212),
          scaffoldBackgroundColor: Color(0xff121212),
          cardColor: Color(0xff121212),
          bottomAppBarColor: Color(0xff121212),
          errorColor: Colors.red.shade400,
          indicatorColor: Colors.lightGreen.shade500
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
