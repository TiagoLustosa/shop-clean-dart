import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_event.dart';
import '../../../domain/usecases/base_usecase/base_usecase.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final UseCase productUseCase;
  ProductBloc({
    required this.productUseCase,
  }) : super(const ProductStart()) {
    on<GetProduct>(getProduct);
  }
  FutureOr<void> getProduct(
      GetProduct event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await productUseCase(event.id);
    emit(result.fold(
      (l) => ProductError(l),
      (r) => ProductSuccess(r),
    ));
  }
}
