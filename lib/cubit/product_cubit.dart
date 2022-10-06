import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  List<ProductModel>? productModel = [];
 final Map<String , dynamic>? categoriesData ={};
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
print("getProductData ProductLoaded 1 $favouriteList");
        emit(
          ProductLoaded(
              productModel: productModal,
              favList: favouriteList,
              addToCartList: addToCaList,categoriesData: categoriesData),
        );
      });
    } else {
      print("getProductData ProductLoaded 2 $favouriteList");

      emit(
        ProductLoaded(
            productModel: productModel,
            favList: favouriteList,
            addToCartList: addToCaList,categoriesData: categoriesData),
      );
    }
  }

  void getProductByCategories(String categoriesName) {
     List<ProductModel> tempModal = [];
    if(categoriesData!.keys.contains(categoriesName)){}
    else{
    for (int i = 0; i < productModel!.length; i++) {
      if (productModel![i].category == categoriesName) {
        tempModal.add(productModel![i]);
        categoriesData![categoriesName] = tempModal;
      }
    }
    ProductLoaded(productModel: productModel ,favList: favouriteList ,addToCartList: addToCaList ,categoriesData: categoriesData);
    print("getProductByCategories  ProductByCategory 1");
    // emit(ProductByCategory(categoriesData: categoriesData));
  }}



  void updateFavouriteList(ProductModel favItem) {
    var index = productModel!.indexWhere((element) => element.id == favItem.id);
print("updateFavouriteList");
    if (favIds!.contains(favItem.id)) {
      favouriteList!.remove(favItem);
      print(favouriteList);
      favIds!.remove(favItem.id!);
      productModel![index].isFavourite = false;
      print("getProductData ProductLoaded 1 $favouriteList");

      // emit(
      //   ProductLoaded(
      //       productModel: productModel,
      //       favList: favouriteList,
      //       addToCartList: addToCaList,categoriesData: categoriesData),
      // );
    } else {
      favouriteList!.add(favItem);
      favIds!.add(favItem.id!);
      productModel![index].isFavourite = true;
      print("getProductData ProductLoaded 1 $favouriteList");

      // emit(
      //   ProductLoaded(
      //       productModel: productModel,
      //       favList: favouriteList,
      //       addToCartList: addToCaList,categoriesData: categoriesData),
      // );
    }

    emit(
        FavouriteUpdated(productModel: productModel, favList: favouriteList));

    // emit(
    //     FavouriteUpdated(productModel: productModel, favList: favouriteList));
    // emit(ProductLoaded(
    //     productModel: productModel!,
    //     favList: favouriteList,
    //     addToCartList: addToCaList));
    // for (var i = 0; i < favouriteList!.length; i++) {
    // }
    // for (var i = 0; i < favIds!.length; i++) {
    // }
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

    // for (var i = 0; i < addToCaList!.length; i++) {
    //   print("add To Cart List id ${addToCaList![i].id}");
    // }
    // for (var i = 0; i < addToCartIds!.length; i++) {
    //   print("updateAddToCaList addToCartIds ${addToCartIds![i]}");
    // }
  }

  void updateFavouriteListFromDetailScreen(ProductModel favItem) {
    var index = productModel!.indexWhere((element) => element.id == favItem.id);

    if (favIds!.contains(favItem.id)) {
      favouriteList!.removeWhere((element) => element.title == favItem.title);
      // favouriteList!.remove(favItem);
      favIds!.remove(favItem.id!);
      productModel![index].isFavourite = false;
    } else {
      favouriteList!.add(favItem);
      favIds!.add(favItem.id!);
      productModel![index].isFavourite = true;
    }

    // for (var i = 0; i < favouriteList!.length; i++) {
    //   print(">>>>>>>${favouriteList![i].id}");
    // }

    print("updateFavouriteListFromDetailScreen  FavouriteUpdated 1");

    for (var i = 0; i < favIds!.length; i++) {
      // print("<<<<<<<${favIds![i]}");
      emit(
          FavouriteUpdated(productModel: productModel, favList: favouriteList));
    }
  }

  void updateAddToCaListFromDetailScreen(ProductModel item) {
    var index = productModel!.indexWhere((element) => element.id == item.id);

    if (addToCartIds!.contains(item.id)) {
      addToCaList!.removeWhere((element) => element.title == item.title);
      // favouriteList!.remove(favItem);
      addToCartIds!.remove(item.id!);
      productModel![index].isAddToCart = false;
    } else {
      addToCaList!.add(item);
      addToCartIds!.add(item.id!);
      productModel![index].isAddToCart = true;
    }
    print("updateAddToCaListFromDetailScreen  AddToCaUpdated 1");

    emit(AddToCaUpdated(productModel: productModel, addToCaList: addToCaList));
    // for (var i = 0; i < addToCaList!.length; i++) {
    //   print(">>>>>>>${addToCaList![i].id}");
    // }
    // for (var i = 0; i < addToCartIds!.length; i++) {
    //   print("<<<<<<<${addToCartIds![i]}");
    // }
  }
}
