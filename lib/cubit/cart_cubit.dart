import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:equatable/equatable.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartModel> cartModel = [];
  // List<CartModal> cartProductDataList = [];

  // List<ProductModel>? productModel = [];
  // fzApiService().getProducts();
  final Future<List<CartModel>?> fetchCartModelData =
      ApiService().getCartProduct();

  CartCubit() : super(CartInitial());

  void getUserCartData() {
    fetchCartModelData
        .then((cartModel) => emit(CartLoaded(cartModel: cartModel!)));
  }

  // void getCartData(List<CartModel> cartModel ,List<ProductModel> productModel) {
  //
  //   if(cartModel.length != null && productModel.length != null){
  //     for(int i = 0 ; i < cartModel.length ; i++){
  //       for(int j = 0 ; j<productModel.length ; j++){
  //         if(cartModel[0].products?[i].productId == productModel[j].id ){
  //           cartProductDataList.add({
  //             'pdtImg': productModel[i].image
  //                 .toString(),
  //             'pdtTitle': productModel[i].title
  //                 .toString(),
  //             'pdtPrice': productModel[i].price,
  //             'crtPdtCount': cartModel[0].products![j].quantity,
  //             "productId": cartModel[0].products![j].productId
  //           });
  //         }
  //       }
  //     }
  //
  //   }
  //   emit(SortedCartData(cartProductDataList :cartProductDataList )) ;
  // }

  // double _getTotalAmount() {
  //   double totalAmount=0.0;
  //   List<double> productAll = [];
  //   for (var key in cartProductDataList) {
  //     var temp = 0.0;
  //     temp = key["pdtPrice"] * key["crtPdtCount"];
  //     productAll.add(temp);
  //   }
  //   for (var i in productAll) {
  //     totalAmount = totalAmount + i;
  //   }
  //
  //   return totalAmount.ceilToDouble();
  // }
}
