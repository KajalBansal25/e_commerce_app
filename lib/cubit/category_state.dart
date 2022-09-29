// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CatergoryLoaded extends CategoryState {
  // final List<ProductModel> categoryModel;
  final String categoryName;
  final Map<String, dynamic> listOfAllCatergory;
  const CatergoryLoaded({
    required this.listOfAllCatergory,
    required this.categoryName,
  });
  // List<Map<String, dynamic>> assignFun() {
  //   // ignore: iterable_contains_unrelated_type
  //   if (listOfAllCatergory.contains(categoryName)) {
  //   } else {
  //     listOfAllCatergory.add({categoryName: categoryModel});
  //   }
  //   return listOfAllCatergory;
  // }
}
