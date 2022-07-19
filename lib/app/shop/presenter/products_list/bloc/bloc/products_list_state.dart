part of 'products_list_bloc.dart';

abstract class ProductsListState extends Equatable {
  const ProductsListState();

  @override
  List<Object> get props => [];
}

class ProductsListInitial extends ProductsListState {}

class ProductsListLoading extends ProductsListState {}

class ProductsListError extends ProductsListState {
  final Exception error;
  const ProductsListError(this.error);
  @override
  List<Object> get props => [error];
}

class ProductsListSuccess extends ProductsListState {
  final List<ProductResultModel> products;
  const ProductsListSuccess(this.products);
  @override
  List<Object> get props => [products];
  int get totalProducts => products.length;
}
