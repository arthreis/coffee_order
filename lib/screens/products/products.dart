import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/screens/products/product_card.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  final String user;

  const ProductsPage({Key key, this.user}): super(key: key);

  @override
  ProductsPageState createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage> {
  List<ProductCard> productCards = [];
  
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, ${widget.user}"),
      ),
      body: ListView(children: _gerarProdutos()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            Text('R\$ $_total'),
            FlatButton.icon(
              label: Text('Share'),
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _gerarProdutos() {
    List<Product> products = [
      Product(name: 'Espresso Vanilla', price: 2.25),
      Product(name: 'Espresso Caramel', price: 2.25),
      Product(name: 'Espresso 1', price: 1.85),
      Product(name: 'Espresso 2', price: 2.05),
      Product(name: 'Espresso 3', price: 2.25),
      Product(name: 'Espresso 4', price: 2.25),
      Product(name: 'Espresso 5', price: 1.85),
      Product(name: 'Espresso 6', price: 1.85),
      Product(name: 'Espresso 7', price: 2.25),
      Product(name: 'Espresso 8', price: 1.85),
      Product(name: 'Espresso 9', price: 1.85),
      Product(name: 'Espresso 0', price: 2.05),
    ];

    for (Product product in products) {
      productCards.add(ProductCard(product: product));
    }

    return productCards;
  }
}
