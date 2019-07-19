import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(nullable: false)
class OrderItem {
  int quantity;
  double subtotal;

  OrderItem({@required this.quantity, @required this.subtotal});

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
