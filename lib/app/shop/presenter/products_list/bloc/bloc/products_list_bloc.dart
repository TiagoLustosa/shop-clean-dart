import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/usecases/base_usecase/base_usecase.dart';
import '../../../../infra/models/product_result_model.dart';
part 'products_list_event.dart';
part 'products_list_state.dart';

@injectable
class ProductsListBloc extends Bloc<GetProductsList, ProductsListState> {
  final UseCase<List<ProductResultModel>, NoParams> usecase;
  ProductsListBloc({required this.usecase}) : super(ProductsListInitial()) {
    on<GetProductsList>(getProductsList);
    on<GetProductDetail>(getProductDetail);
  }
  FutureOr<void> getProductsList(
      GetProductsList event, Emitter<ProductsListState> emit) async {
    emit(ProductsListLoading());
    final result = await usecase(NoParams());
    emit(result.fold(
      (l) => ProductsListError(l),
      (r) => ProductsListSuccess(r),
    ));
  }

  FutureOr<void> getProductDetail(
      GetProductDetail event, Emitter<ProductsListState> emit) async {
    emit(ProductsListLoading());
    final result = await usecase(NoParams());
    result.fold((l) => null, (r) => ProductsListSuccess(r));
  }
}
