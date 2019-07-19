import 'package:coffee_order/api/api.dart';
import 'package:coffee_order/models/order.dart';
import 'package:coffee_order/models/order_item.dart';
import 'package:coffee_order/models/product.dart';
import 'package:coffee_order/screens/home.dart';
import 'package:coffee_order/components/product_card.dart';
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
  Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = getProducts();
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
              label: Text('Share'),
              icon: Icon(Icons.share),
              onPressed: _shareOrder,
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

  void _shareOrder() async {
    if (productCards.any((item) => item.orderItem.quantity > 0)) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<OrderItem> orderItems = productCards.map((pc) => OrderItem(
          quantity: pc.orderItem.quantity, subtotal: pc.orderItem.subtotal));

      Order order = Order.fromJson(preferences.get('user'));

      var orderString = preferences.getString('user') +
          ',' +
          productCards
              .map((productCard) => productCard.orderItem.quantity.toString())
              .join(',');

      Share.share(orderString);
      Api().saveOrder(order);
    } else {
      SnackBar mensagemErro = SnackBar(
        content: Text('Pedido vazio!'),
        backgroundColor: Colors.redAccent,
      );
      _scaffoldKey.currentState.showSnackBar(mensagemErro);
    }
  }

  void _logout() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  Future<List<Product>> getProducts() {
    return Api().getCoffees();
  }
}
