import 'package:coffee_order/component/product_card.dart';
import 'package:coffee_order/dto/user.dart';
import 'package:coffee_order/model/product_model.dart';
import 'package:coffee_order/model/user_model.dart';
import 'package:coffee_order/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  final String userName;

  const ProductsPage({Key key, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context, listen: false);

    return ChangeNotifierProvider<ProductModel>(
      create: (context) => ProductModel(context),
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                  title: Text('Produtos'),
                  selected: true,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                title: Text('Histórico'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Olá, ${StringUtils.getFirstName(userName)}"),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.exit_to_app),
              onPressed: userModel.logout,
            )
          ],
        ),
        body: Consumer<ProductModel>(
          builder: (context, productModel, child) {
            if (productModel.error) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text("Erro ao buscar produtos."),
                    RaisedButton(
                        child: Text("Tentar novamente"),
                        color: Colors.black12,
                        onPressed: () => productModel.buscarProdutos(context))
                  ]));
            }
            if (productModel.products.length > 0) {
              return ListView.builder(
                  itemCount: productModel.products.length,
                  itemBuilder: (context, index) => ProductCard(index));
            }
            return Container(
                constraints: BoxConstraints.expand(),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(child: CircularProgressIndicator()));
          },
        ),
        bottomNavigationBar: Builder(
          builder: (context) {
            final productModel =
                Provider.of<ProductModel>(context, listen: false);
            final userModel = Provider.of<UserModel>(context, listen: false);
            return BottomAppBar(
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Consumer<ProductModel>(
                      builder: (context, productModel, child) =>
                          Text(StringUtils.formatPrice(productModel.total))),
                  FlatButton.icon(
                    label: Text('Finalizar Pedido'),
                    icon: Icon(Icons.share),
                    onPressed: () => productModel.checkout(
                        context,
                        userModel.userDto),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
