// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
      quantity: json['quantity'] as int,
      subtotal: (json['subtotal'] as num).toDouble());
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'subtotal': instance.subtotal
    };
