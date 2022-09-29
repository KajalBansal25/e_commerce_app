import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  List<ProductModel>? productModel = [];
  List<ProductModel>? favouriteList = [];
  List<ProductModel>? addToCaList = [];
  List<int>? ids = [];
  List<int>? productId = [];

  ProductCubit() : super(ProductInitial());

  final Future<List<ProductModel>?> fetchData = ApiService().getProducts();

  void getProductData() {
    if (productModel != []) {
      fetchData.then((productModal) {
        productModel = productModal;

        emit(ProductLoaded(
            productModel: productModal!,
            favList: favouriteList,
            addToCartList: addToCaList));
      });
    } else {
      emit(ProductLoaded(
          productModel: productModel!,
          favList: favouriteList,
          addToCartList: addToCaList));
    }
    print(" getProductData : Product Loaded");
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
    // emit(
    //     FavouriteUpdated(productModel: productModel, favList: favouriteList));
    // emit(ProductLoaded(
    //     productModel: productModel!,
    //     favList: favouriteList,
    //     addToCartList: addToCaList));
    for (var i = 0; i < favouriteList!.length; i++) {
      print(">>>>>>>${favouriteList![i].id}");
    }
    for (var i = 0; i < ids!.length; i++) {
      print("<<<<<<<${ids![i]}");
    }
  }

  void updateAddToCaList(ProductModel item) {
    var index = productModel!.indexWhere((element) => element.id == item.id);

    if (productId!.contains(item.id)) {
      addToCaList!.remove(item);
      productId!.remove(item.id!);
      productModel![index].isAddToCart = false;
    } else {
      addToCaList!.add(item);
      productId!.add(item.id!);
      productModel![index].isAddToCart = true;
    }

    for (var i = 0; i < addToCaList!.length; i++) {
      print("add To Cart List id ${addToCaList![i].id}");
    }
    for (var i = 0; i < productId!.length; i++) {
      print("updateAddToCaList productId ${productId![i]}");
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

    for (var i = 0; i < favouriteList!.length; i++) {
      print(">>>>>>>${favouriteList![i].id}");
    }
    for (var i = 0; i < ids!.length; i++) {
      print("<<<<<<<${ids![i]}");
      emit(
          FavouriteUpdated(productModel: productModel, favList: favouriteList));
    }
  }

  void updateAddToCaListFromDetailScreen(ProductModel item) {
    var index = productModel!.indexWhere((element) => element.id == item.id);

    if (productId!.contains(item.id)) {
      addToCaList!.removeWhere((element) => element.title == item.title);
      // favouriteList!.remove(favItem);
      productId!.remove(item.id!);
      productModel![index].isAddToCart = false;
    } else {
      addToCaList!.add(item);
      productId!.add(item.id!);
      productModel![index].isAddToCart = true;
    }

    emit(AddToCaUpdated(productModel: productModel, addToCaList: addToCaList));
    for (var i = 0; i < addToCaList!.length; i++) {
      print(">>>>>>>${addToCaList![i].id}");
    }
    for (var i = 0; i < productId!.length; i++) {
      print("<<<<<<<${productId![i]}");
    }
  }
}
