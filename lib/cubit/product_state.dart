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
  const ProductLoaded({
    required this.productModel,
    required this.favList,
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
