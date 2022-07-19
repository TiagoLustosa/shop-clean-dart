part of 'products_list_bloc.dart';

abstract class ProductsListEvent extends Equatable {
  const ProductsListEvent();

  @override
  List<Object> get props => [];
}

class GetProductsList extends ProductsListEvent {}

class GetProductDetail extends GetProductsList {}
