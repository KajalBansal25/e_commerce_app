import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'add_to_cart.g.dart';

@JsonSerializable()
class AddToCart extends Equatable {
  int productId;
  int? quantity;
  String? title;
  double? price;
  String? image;
  bool? isDeleted;
  bool? isDone;

  AddToCart({
    this.image,
    this.price,
    required this.productId,
    this.title,
    this.quantity,
    this.isDone,
    this.isDeleted,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  AddToCart copyWith({
    int? productId,
    int? quantity,
    String? title,
    double? price,
    String? image,
    bool? isDeleted,
    bool? isDone,
  }) {
    return AddToCart(
      image: image ?? this.image,
      price: price ?? this.price,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      quantity: quantity ?? this.quantity,
      isDeleted: isDeleted ?? this.isDeleted,
      productId: productId ?? this.productId,
    );
  }

  factory AddToCart.fromJson(Map<String, dynamic> json) =>
      _$AddToCartFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartToJson(this);

  @override
  List<Object?> get props => [
        image,
        price,
        title,
        quantity,
      ];
}
