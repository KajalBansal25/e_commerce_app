import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  List<String> categoryList = [];
  List<ProductModel> categoryModel = [];
  List<int> favids = [];
  List<int> addToCartids = [];
  final Map<String, dynamic> listOfAllCatergory = {};

  CategoryCubit() : super(CategoryInitial());

  void getProdByCategory(String categoryName) {
    if (listOfAllCatergory.keys.contains(categoryName)) {
      emit(CatergoryLoaded(
          listOfAllCatergory: listOfAllCatergory, categoryName: categoryName));
    } else {
      ApiService().getProductsByCategory(categoryName).then((categoryModel) {
        listOfAllCatergory[categoryName] = categoryModel;
        emit(CatergoryLoaded(
            listOfAllCatergory: listOfAllCatergory,
            categoryName: categoryName));
      });
    }
  }

  void updateCateogyState() {
    emit(CategoryInitial());
  }

  void updateFavouriteList(int favid) {
    if (favids.contains(favid)) {
      listOfAllCatergory.forEach((key, value) {
        for (var i = 0; i < value.length; i++) {
          if (favids.contains(listOfAllCatergory[key][i].id) &&
              listOfAllCatergory[key][i].id == favid) {
            listOfAllCatergory[key][i].isFavourite = false;
          }
        }
        favids.remove(favid);
      });
    } else {
      favids.add(favid);
      listOfAllCatergory.forEach((key, value) {
        for (var i = 0; i < value.length; i++) {
          if (favids.contains(listOfAllCatergory[key][i].id) &&
              listOfAllCatergory[key][i].id == favid) {
            listOfAllCatergory[key][i].isFavourite = true;
          }
        }
      });
    }
  }


  void updateAddToCartList(int? itemid) {
    if (addToCartids.contains(itemid)) {
      listOfAllCatergory.forEach((key, value) {
        for (var i = 0; i < value.length; i++) {
          if (addToCartids.contains(listOfAllCatergory[key][i].id) &&
              listOfAllCatergory[key][i].id == itemid) {
            listOfAllCatergory[key][i].isAddToCart = false;
          }
        }
        addToCartids.remove(itemid);
      });
    } else {
      addToCartids.add(itemid!);
      listOfAllCatergory.forEach((key, value) {
        for (var i = 0; i < value.length; i++) {
          if (addToCartids.contains(listOfAllCatergory[key][i].id) &&
              listOfAllCatergory[key][i].id == itemid) {
            listOfAllCatergory[key][i].isAddToCart = true;
          }
        }
      });
    }
  }
}
