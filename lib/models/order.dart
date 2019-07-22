import 'package:coffee_order/models/order_item.dart';
import 'package:coffee_order/models/user.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(nullable: false)
class Order {
  final User user;
  final List<OrderItem> items;

  Order({@required this.user, @required this.items});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
