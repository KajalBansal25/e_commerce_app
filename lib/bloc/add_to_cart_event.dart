part of 'add_to_cart_bloc.dart';

abstract class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object> get props => [];
}

class AddProductToCart extends AddToCartEvent {
  final AddToCart addToCart;
  const AddProductToCart({required this.addToCart});
  @override
  List<Object> get props => [addToCart];
}
