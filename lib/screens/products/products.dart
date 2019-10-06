import 'dart:convert';

import 'package:coffee_order/api/api.dart';
import 'package:coffee_order/components/product_card.dart';
import 'package:coffee_order/models/order.dart';
import 'package:coffee_order/models/order_item.dart';
import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/models/user.dart';
import 'package:coffee_order/screens/home.dart';
import 'package:coffee_order/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsPage extends StatefulWidget {
  final String userName;

  const ProductsPage({Key key, this.userName}) : super(key: key);

  @override
  ProductsPageState createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage> {
  List<ProductCard> productCards = [];
  double _total = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = Api().getCoffees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Olá, ${widget.userName}"),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.exit_to_app),
            onPressed: _logout,
          )
        ],
      ),
      body: FutureBuilder(
        future: products,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(children: _gerarProdutos(snapshot.data));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(StringUtils.formatPrice(_total)),
            FlatButton.icon(
              label: Text('Finalizar Pedido'),
              icon: Icon(Icons.share),
              onPressed: _checkout,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _gerarProdutos(List<Product> products) {
    if (productCards.length > 0) {
      return productCards;
    }

    for (Product product in products?? []) {
      productCards.add(ProductCard(product, callback: _updateTotal));
    }

    return productCards;
  }

  void _updateTotal(deltaPrice) {
    setState(() {
      _total += deltaPrice;
    });
  }

  void _checkout() async {
    if (productCards.any((item) => item.orderItem.quantity > 0)) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = User.fromJson(jsonDecode(preferences.getString('userJson')));
      if (user == null) {
        throw Exception('ERROR: authentication is required');
      }

      List<OrderItem> orderItems =
          productCards.where((pc) => pc.orderItem.quantity > 0).map((pc) => pc.orderItem).toList();
      Order order = Order(user: user, items: orderItems);

      try {
        await Api().saveOrder(order);

        SnackBar mensagemErro = SnackBar(
          content: Text('Pedido salvo com sucesso.'),
          backgroundColor: Colors.lightGreen,
          duration: Duration(seconds: 4),
        );
        _scaffoldKey.currentState.showSnackBar(mensagemErro);
      } on Exception {
        SnackBar mensagemErro = SnackBar(
          content: Text('Ocorreu um erro ao salvar seu pedido. Tente novamente.'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 4),
        );
        _scaffoldKey.currentState.showSnackBar(mensagemErro);
      }
    } else {
      SnackBar mensagemErro = SnackBar(
        content: Text('Pedido vazio!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 4),
      );
      _scaffoldKey.currentState.showSnackBar(mensagemErro);
    }
  }

  void _logout() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.remove('userJson');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}
