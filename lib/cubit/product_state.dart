// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel>? productModel;
  final List<ProductModel>? favList;
  final List<ProductModel>? addToCartList;
  final Map<String, dynamic>? categoriesData;

  const ProductLoaded({
    required this.productModel,
    required this.favList,
    required this.addToCartList,
    required this.categoriesData,
  });
}

class FavouriteUpdated extends ProductState {
  final List<ProductModel>? productModel;
  final List<ProductModel>? favList;

  const FavouriteUpdated({
    required this.productModel,
    required this.favList,
  });
}

class AddToCaUpdated extends ProductState {
  final List<ProductModel>? productModel;
  final List<ProductModel>? addToCaList;

  const AddToCaUpdated({
    required this.productModel,
    required this.addToCaList,
  });
}

class ProductByCategory extends ProductState {
  final List<ProductModel>? categoriesData;
  const ProductByCategory({
    required this.categoriesData,
  });
}
