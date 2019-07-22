import 'package:coffee_order/models/product.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(nullable: false)
class OrderItem {
  int quantity;
  double subtotal;
  Product product;

  OrderItem({@required this.quantity, @required this.subtotal, @required this.product});

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
