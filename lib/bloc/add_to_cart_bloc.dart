import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

import '../model/add_to_cart.dart';

part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  AddToCartBloc() : super(const AddToCartState()) {
    on<AddProductToCart>(_onAddProductToCart);
  }

  void _onAddProductToCart(
      AddProductToCart event, Emitter<AddToCartState> emit) {
    final state = this.state;
    emit(AddToCartState(
      allCartProduct: List.from(state.allCartProduct)..add(event.addToCart),
    ));
  }
}
