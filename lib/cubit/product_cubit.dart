import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  List<ProductModel>? productModel = [];
  List<ProductModel>? favouriteList = [];
  List<int>? ids = [];

  ProductCubit() : super(ProductInitial());

  final Future<List<ProductModel>?> fetchData = ApiService().getProducts();

  void getProductData() {
    if (productModel != []) {
      fetchData.then((productModal) {
        productModel = productModal;
        emit(
            ProductLoaded(productModel: productModal!, favList: favouriteList));
      });
    } else {
      emit(ProductLoaded(productModel: productModel!, favList: favouriteList));
    }

    print("ProductLoaded");
  }

  void updateFavouriteList(ProductModel favItem) {
    var index = productModel!.indexWhere((element) => element.id == favItem.id);

    if (ids!.contains(favItem.id)) {
      favouriteList!.remove(favItem);
      ids!.remove(favItem.id!);
      productModel![index].isFavourite = false;
    } else {
      favouriteList!.add(favItem);
      ids!.add(favItem.id!);
      productModel![index].isFavourite = true;
    }
    for (var i = 0; i < favouriteList!.length; i++) {
      print(">>>>>>>${favouriteList![i].id}");
    }
    for (var i = 0; i < ids!.length; i++) {
      print("<<<<<<<${ids![i]}");
    }
  }

  void updateFavouriteListFromDetailScreen(ProductModel favItem) {
    var index = productModel!.indexWhere((element) => element.id == favItem.id);

    if (ids!.contains(favItem.id)) {
      favouriteList!.removeWhere((element) => element.title == favItem.title);
      // favouriteList!.remove(favItem);
      ids!.remove(favItem.id!);
      productModel![index].isFavourite = false;
    } else {
      favouriteList!.add(favItem);
      ids!.add(favItem.id!);
      productModel![index].isFavourite = true;
    }

    emit(FavouriteUpdated(productModel: productModel, favList: favouriteList));
    for (var i = 0; i < favouriteList!.length; i++) {
      print(">>>>>>>${favouriteList![i].id}");
    }
    for (var i = 0; i < ids!.length; i++) {
      print("<<<<<<<${ids![i]}");
    }
  }
}
