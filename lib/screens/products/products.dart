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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Olá, ${widget.user}"),
        ),
        body: ListView(children: _gerarProdutos()));
  }

  List<Widget> _gerarProdutos() {
    List<Product> products = [
      Product(name: 'Espresso Vanilla', price: 2.25),
      Product(name: 'Espresso Caramel', price: 2.25),
    ];

    for (Product product in products) {
      productCards.add(ProductCard(product: product));
    }

    return productCards;
  }
}
