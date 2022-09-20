import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:equatable/equatable.dart';
import '../model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartModel> cartModel = [];

  CartCubit() : super(CartInitial());

  void getUserCartData() {
    ApiService()
        .getCartProduct()
        .then((cartModel) => emit(CartLoaded(cartModel: cartModel!)));
  }
}
