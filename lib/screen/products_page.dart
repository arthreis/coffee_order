import 'package:coffee_order/component/product_card.dart';
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
      child: Container(
        child: Scaffold(
          drawer: Drawer(
            elevation: 3.0,
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
                child: Icon(Icons.exit_to_app, color: Theme.of(context).primaryTextTheme.body1.color),
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
                return RefreshIndicator(
                  onRefresh: () => productModel.buscarProdutos(context),
                  child: ListView.builder(
                    itemCount: productModel.products.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: ProductCard(index),
                    ),
                  ),
                );
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
              return SafeArea(
                minimum: EdgeInsets.only(bottom: 3.0),
                child: BottomAppBar(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Consumer<ProductModel>(
                            builder: (context, productModel, child) =>
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Total', style: Theme.of(context).textTheme.caption),
                                    Text(StringUtils.formatPrice(productModel.total), style: Theme.of(context).textTheme.subhead.copyWith(color: Theme.of(context).accentColor)),
                                  ],
                                )),
                        FlatButton.icon(
                          color: Theme.of(context).accentColor,
                          label: Text('Finalizar Pedido', style: Theme.of(context).accentTextTheme.body2,),
                          icon: Icon(Icons.check, color: Theme.of(context).accentTextTheme.body2.color,),
                          onPressed: () =>
                              productModel.checkout(context, userModel.userDto),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
