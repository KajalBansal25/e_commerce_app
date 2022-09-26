// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCart _$AddToCartFromJson(Map<String, dynamic> json) => AddToCart(
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      productId: json['productId'] as int,
      title: json['title'] as String?,
      quantity: json['quantity'] as int?,
      isDone: json['isDone'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$AddToCartToJson(AddToCart instance) => <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'title': instance.title,
      'price': instance.price,
      'image': instance.image,
      'isDeleted': instance.isDeleted,
      'isDone': instance.isDone,
    };
