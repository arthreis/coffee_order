import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/screens/products/product_card.dart';
import 'package:coffee_order/util/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Olá, ${widget.userName}"),
      ),
      body: ListView(children: _gerarProdutos()),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(StringUtils.formatPrice(_total)),
            FlatButton.icon(
              label: Text('Share'),
              icon: Icon(Icons.share),
              onPressed: _shareOrder,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _gerarProdutos() {
    if (productCards.length > 0) {
      return productCards;
    }

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
      productCards.add(ProductCard(product: product, callback: _updateTotal));
    }

    return productCards;
  }

  void _updateTotal(deltaPrice) {
    setState(() {
      _total += deltaPrice;
    });
  }

  Product _createProduct(String name, double price) {
    String path = 'assets/images/coffee_icons/';
    String imageName =
        name.split(' ').map((name) => name.toLowerCase()).join('-') + '.webp';

    return Product(name: name, price: price, imagePath: path + imageName);
  }

  void _shareOrder() async {
    if (productCards.any((item) => item.order.quantity > 0)) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var orderString = preferences.getString('user') +
          ',' +
          productCards
              .map((productCard) => productCard.order.quantity.toString())
              .join(',');

      Share.share(orderString);
    } else {
      SnackBar mensagemErro = SnackBar(content: Text('Pedido vazio!'), backgroundColor: Colors.redAccent,);
      _scaffoldKey.currentState.showSnackBar(mensagemErro);
    }
  }
}
