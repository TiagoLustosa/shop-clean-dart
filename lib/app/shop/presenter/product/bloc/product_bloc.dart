import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/contracts/add_product_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/contracts/delete_product_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/contracts/get_product_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/contracts/update_product_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_event.dart';
import 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IGetProductUseCase getProductUseCase;
  final IAddProductUseCase addProductUseCase;
  final IUpdateProductUseCase updateProductUseCase;
  final IDeleteProductUseCase deleteProductUseCase;

  ProductBloc({
    required this.getProductUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  }) : super(const ProductStart()) {
    on<GetProduct>(getProduct);
    on<AddProduct>(addProduct);
    on<UpdateProduct>(updateProduct);
    on<DeleteProduct>(deleteProduct);
  }
  FutureOr<void> getProduct(
      GetProduct event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await getProductUseCase(event.id);
    emit(result.fold(
      (l) => ProductError(l),
      (r) => ProductSuccess(r),
    ));
  }

  FutureOr<void> addProduct(
      AddProduct event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await addProductUseCase(event.product);
    emit(result.fold(
      (l) => ProductError(l),
      (r) => ProductSuccess(r),
    ));
  }

  FutureOr<void> updateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await updateProductUseCase(event.product);
    emit(result.fold(
      (l) => ProductError(l),
      (r) => ProductSuccess(r),
    ));
  }

  FutureOr<void> deleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(const ProductLoading());
    final result = await deleteProductUseCase(event.id);
    emit(result.fold(
      (l) => ProductError(l),
      (r) => ProductDeletedSuccess(r),
    ));
  }
}
