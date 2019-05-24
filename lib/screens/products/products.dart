import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/screens/products/product_card.dart';
import 'package:coffee_order/util/string_utils.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  final String user;

  const ProductsPage({Key key, this.user}) : super(key: key);

  @override
  ProductsPageState createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage> {
  List<ProductCard> productCards = [];

  double _total = 0;

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
            Text(StringUtils.formatPrice(_total)),
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
      _createProduct('Ristretto Intenso', 2.05),
      _createProduct('Ristretto Origin India', 2.25),
      _createProduct('Ristretto', 1.85),
      _createProduct('Espresso Forte', 1.85),
      _createProduct('Espresso Leggero', 1.85),
      _createProduct('Espresso Origin Brazil', 2.25),
      _createProduct('Lungo Origin Guatemala', 2.25),
      _createProduct('Lungo Forte', 1.85),
      _createProduct('Lungo Leggero', 1.85),
      _createProduct('Espresso Decaffeinato', 1.85),
      _createProduct('Lungo Decaffeinato', 1.85),
      _createProduct('Espresso Vanilla', 2.25),
      _createProduct('Espresso Caramel', 2.25),
    ];

    for (Product product in products) {
      productCards.add(ProductCard(product: product, callback: updateTotal));
    }

    return productCards;
  }

  void updateTotal(deltaPrice) {
    setState(() {
      _total += deltaPrice;
    });
  }

  _createProduct(String name, double price) {
    String path = 'assets/images/coffee_icons/';
    String imageName = name.split(' ').map((name) => name.toLowerCase()).join('-') + '.webp';
    
    return Product(name: name, price: price, imagePath: path + imageName);
  }
}
