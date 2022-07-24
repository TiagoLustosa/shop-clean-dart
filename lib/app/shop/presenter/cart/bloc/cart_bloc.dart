import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/add_or_update_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/get_from_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final IAddOrUpdateCartUseCase addOrUpdateCartUseCase;
  final IGetFromCartUseCase getFromCartUseCase;
  CartBloc({
    required this.addOrUpdateCartUseCase,
    required this.getFromCartUseCase,
  }) : super(CartInitial()) {
    on<AddOrUpdateCart>(addOrUpdateCart);
    on<GetFromCart>(getFromCart);
  }
  FutureOr<void> addOrUpdateCart(AddOrUpdateCart event, Emitter emit) async {
    emit(CartLoading());
    final result = await addOrUpdateCartUseCase(event.product);
    emit(result.fold(
      (l) => CartError(l),
      (r) => CartSuccess(r),
    ));
  }

  FutureOr<void> getFromCart(GetFromCart event, Emitter emit) async {
    emit(CartLoading());
    final result = await getFromCartUseCase(event.userId);
    emit(result.fold(
      (l) => CartError(l),
      (r) => CartSuccess(r!),
    ));
  }
}