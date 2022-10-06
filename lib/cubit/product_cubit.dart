import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  List<ProductModel>? productModel = [];
  final Map<String, dynamic>? categoriesData = {};
  List<ProductModel>? favouriteList = [];
  List<ProductModel>? addToCaList = [];
  List<int>? favIds = [];
  List<int>? addToCartIds = [];

  ProductCubit() : super(ProductInitial());

  final Future<List<ProductModel>?> fetchData = ApiService().getProducts();

  void getProductData() {
    if (productModel != []) {
      fetchData.then((productModal) {
        productModel = productModal!;
        emit(
          ProductLoaded(
              productModel: productModal,
              favList: favouriteList,
              addToCartList: addToCaList,
              categoriesData: categoriesData),
        );
      });
    } else {
      emit(
        ProductLoaded(
            productModel: productModel,
            favList: favouriteList,
            addToCartList: addToCaList,
            categoriesData: categoriesData),
      );
    }
  }

  void getProductByCategories(String categoriesName) {
    List<ProductModel> tempModal = [];
    if (categoriesData!.keys.contains(categoriesName)) {
    } else {
      for (int i = 0; i < productModel!.length; i++) {
        if (productModel![i].category == categoriesName) {
          tempModal.add(productModel![i]);
          categoriesData![categoriesName] = tempModal;
        }
      }
      ProductLoaded(
          productModel: productModel,
          favList: favouriteList,
          addToCartList: addToCaList,
          categoriesData: categoriesData);
    }
  }

  void updateFavouriteList(ProductModel favItem) {
    var index = productModel!.indexWhere((element) => element.id == favItem.id);
    if (favIds!.contains(favItem.id)) {
      favouriteList!.remove(favItem);
      favIds!.remove(favItem.id!);
      productModel![index].isFavourite = false;
    } else {
      favouriteList!.add(favItem);
      favIds!.add(favItem.id!);
      productModel![index].isFavourite = true;
    }
    emit(FavouriteUpdated(productModel: productModel, favList: favouriteList));
  }

  void updateAddToCaList(ProductModel item) {
    var index = productModel!.indexWhere((element) => element.id == item.id);

    if (addToCartIds!.contains(item.id)) {
      addToCaList!.remove(item);
      addToCartIds!.remove(item.id!);
      productModel![index].isAddToCart = false;
    } else {
      addToCaList!.add(item);
      addToCartIds!.add(item.id!);
      productModel![index].isAddToCart = true;
    }
  }

  void updateFavouriteListFromDetailScreen(ProductModel favItem) {
    var index = productModel!.indexWhere((element) => element.id == favItem.id);

    if (favIds!.contains(favItem.id)) {
      favouriteList!.removeWhere((element) => element.title == favItem.title);
      favIds!.remove(favItem.id!);
      productModel![index].isFavourite = false;
    } else {
      favouriteList!.add(favItem);
      favIds!.add(favItem.id!);
      productModel![index].isFavourite = true;
    }
    emit(FavouriteUpdated(productModel: productModel, favList: favouriteList));
  }

  void updateAddToCaListFromDetailScreen(ProductModel item) {
    var index = productModel!.indexWhere((element) => element.id == item.id);

    if (addToCartIds!.contains(item.id)) {
      addToCaList!.removeWhere((element) => element.title == item.title);
      addToCartIds!.remove(item.id!);
      productModel![index].isAddToCart = false;
    } else {
      addToCaList!.add(item);
      addToCartIds!.add(item.id!);
      productModel![index].isAddToCart = true;
    }
    emit(AddToCaUpdated(productModel: productModel, addToCaList: addToCaList));
  }
}
