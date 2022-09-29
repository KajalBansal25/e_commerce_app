import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartListModel {
  CartListModel({required this.carts});
  final List<CartModel>? carts;

  factory CartListModel.fromJson(Map<String, dynamic> json) =>
      _$CartListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartListModelToJson(this);
}

@JsonSerializable()
class CartModel {
  CartModel({
    this.id,
    this.userId,
    this.date,
    this.products,
    this.v,
  });

  int? id;
  int? userId;
  String? date;
  List<Product>? products;
  int? v;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable()
class Product {
  Product({
    this.productId,
    this.quantity,
     });

  int? productId;
  int? quantity;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
