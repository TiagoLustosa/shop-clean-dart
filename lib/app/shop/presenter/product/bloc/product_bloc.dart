import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_event.dart';
import '../../../domain/usecases/base_usecase/base_usecase.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final UseCase productUseCase;
  ProductBloc({
    required this.productUseCase,
  }) : super(const ProductStart()) {
    on<AddProduct>(addProduct);
  }
  FutureOr<void> addProduct(
      AddProduct event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await productUseCase(event.product);
    emit(result.fold(
      (l) => ProductError(l),
      (r) => ProductSuccess(r),
    ));
  }
}
