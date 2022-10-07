import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/cart_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartModel> cartModel = [];
  final Future<List<CartModel>?> fetchCartModelData =
      ApiService().getCartProduct();
  CartCubit() : super(CartInitial());
  void getUserCartData() {
    fetchCartModelData
        .then((cartModel) => emit(CartLoaded(cartModel: cartModel!)));
  }
}
