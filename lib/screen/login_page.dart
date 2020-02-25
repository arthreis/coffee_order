import 'package:coffee_order/model/user_model.dart';
import 'package:coffee_order/util/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Builder(builder: (context) {
                if (userModel.error) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    SnackBarUtils.showSnackBar(context,
                        "Não foi possível fazer login. Tente novamente.",
                        false);
                  });
                }
                return MaterialButton(
                    child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              height: 25,
                              image: AssetImage('assets/images/social/g-logo.png'),
                            ),
                            SizedBox(width: 10),
                            Text("Continuar com o Google", style: TextStyle(color: Colors.black87),)
                          ],
                        )),
                    color: Colors.white,
                    onPressed: () => userModel.loginOrSignUp(context));
              })
            ],
          ),
        ),
      ),
    );
  }
}
