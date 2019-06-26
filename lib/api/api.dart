import 'package:coffee_order/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Api {

    static const String BASE_URL = "http://api-coffee-order.herokuapp.com/";

    static const String GET_COFFEES = BASE_URL+"product/coffees";

    Future<List<Product>> getCoffees() async {

        var response = await http.get(GET_COFFEES).catchError((error) {print(error);});
        print(response.body);

        if(response.statusCode == 200){
            final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
            return parsed.map<Product>((json) => Product.fromJson(json)).toList();
        }else{
            throw Exception("ERROR");
        }
    }
}
