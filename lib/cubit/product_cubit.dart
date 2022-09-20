import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:e_commerce_app/constants/api_service.dart';
// import 'package:e_commerce_app/model/single_product_modal.dart';
import 'package:e_commerce_app/model/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  List<ProductModel>? productModel = [];

  final Future<List<ProductModel>?> fetchData = ApiService().getProducts();
  ProductCubit() : super(ProductInitial());

  void getProductData() {
    fetchData.then(
        (productModel) => emit(ProductLoaded(productModel: productModel!)));
  }
}
