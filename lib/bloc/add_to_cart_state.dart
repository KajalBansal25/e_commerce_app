part of 'add_to_cart_bloc.dart';

 class AddToCartState extends Equatable {
  final List<AddToCart> allCartProduct;
  const AddToCartState({
    this.allCartProduct = const <AddToCart>[],
  });

  @override
  List<Object> get props => [allCartProduct];
}

class AddToCartInitial extends AddToCartState {}
