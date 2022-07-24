import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/contracts/get_products_list_usecase_contract.dart';
import '../../../../domain/usecases/base_usecase/base_usecase.dart';
import '../../../../infra/models/product_result_model.dart';
part 'products_list_event.dart';
part 'products_list_state.dart';

@injectable
class ProductsListBloc extends Bloc<GetProductsList, ProductsListState> {
  final IGetProductsListUseCase productsListUseCase;
  ProductsListBloc({required this.productsListUseCase})
      : super(ProductsListInitial()) {
    on<GetProductsList>(getProductsList);
    on<GetProductDetail>(getProductDetail);
  }
  FutureOr<void> getProductsList(
      GetProductsList event, Emitter<ProductsListState> emit) async {
    emit(ProductsListLoading());
    final result = await productsListUseCase(NoParams());
    emit(result.fold(
      (l) => ProductsListError(l),
      (r) => ProductsListSuccess(r as List<ProductResultModel>),
    ));
  }

  FutureOr<void> getProductDetail(
      GetProductDetail event, Emitter<ProductsListState> emit) async {
    emit(ProductsListLoading());
    final result = await productsListUseCase(NoParams());
    result.fold(
        (l) => null, (r) => ProductsListSuccess(r as List<ProductResultModel>));
  }
}
