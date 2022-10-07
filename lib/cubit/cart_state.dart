part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartModel?> cartModel;
  final List<ProductModel?> productData;
  final List cartProductDataList;

  const CartLoaded({
    required this.cartModel,
    required this.productData,
    required this.cartProductDataList,
  });
}
