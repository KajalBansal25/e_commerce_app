import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  // final String categoryName;
  List<String> categoryList = [];
  List<ProductModel> categoryModel = [];
  final Map<String, dynamic> listOfAllCatergory = {};

  CategoryCubit(
      // this.categoryName,
      )
      : super(CategoryInitial());

  void getProdByCategory(String categoryName) {
    if (categoryList.contains(categoryName)) {
    } else {
      ApiService().getProductsByCategory(categoryName).then((categoryModel) {
        categoryList.add(categoryName);

        if (listOfAllCatergory.keys.contains(categoryName)) {
        } else {
          listOfAllCatergory[categoryName] = categoryModel;
        }

        emit(CatergoryLoaded(
            listOfAllCatergory: listOfAllCatergory,
            categoryName: categoryName));
      });
    }
  }

  void updateCateogyState() {
    emit(CategoryInitial());
  }
}
