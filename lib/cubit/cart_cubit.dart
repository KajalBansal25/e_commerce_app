import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/cart_model.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartModel> cartModel = [];
  List<ProductModel> productData = [];
  List cartProductDataList = [];
  CartCubit() : super(CartInitial());

  void getProductAndCartData() async {
    productData = (await ApiService().getProducts())!;
    cartModel = (await ApiService().getCartProduct())!;
    int cLen = cartModel[0].products!.length;
    cartProductDataList = [];
    for (int i = 0; i < cLen; i++) {
      for (int j = 0; j < productData.length; j++) {
        if (cartModel[0].products![i].productId == productData[j].id) {
          cartProductDataList.add({
            'pdtImg': productData[j].image.toString(),
            'pdtTitle': productData[j].title.toString(),
            'pdtPrice': productData[j].price,
            'crtPdtCount': cartModel[0].products![i].quantity,
            "productId": cartModel[0].products![i].productId
          });
        }
      }
    }
    emit(CartLoaded(
        cartModel: cartModel,
        productData: productData,
        cartProductDataList: cartProductDataList));
  }
}
