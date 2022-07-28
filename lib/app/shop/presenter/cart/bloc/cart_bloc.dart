import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/add_or_update_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/clear_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/get_from_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/remove_from_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final IAddOrUpdateCartUseCase addOrUpdateCartUseCase;
  final IGetFromCartUseCase getFromCartUseCase;
  final IRemoveFromCartUseCase removeFromCartUseCase;
  final IClearCartUseCase clearCartUseCase;
  CartBloc({
    required this.addOrUpdateCartUseCase,
    required this.getFromCartUseCase,
    required this.removeFromCartUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial()) {
    on<AddOrUpdateCart>(addOrUpdateCart);
    on<GetFromCart>(getFromCart);
    on<RemoveFromCart>(removeFromCart);
    on<ClearCart>(clearCart);
  }
  FutureOr<void> addOrUpdateCart(AddOrUpdateCart event, Emitter emit) async {
    emit(CartLoading());
    final result =
        await addOrUpdateCartUseCase(event.product, userId: event.userId);
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

  FutureOr<void> removeFromCart(RemoveFromCart event, Emitter emit) async {
    emit(CartLoading());
    final result =
        await removeFromCartUseCase(event.productId, userId: event.userId);
    emit(result.fold(
      (l) => CartError(l),
      (r) => CartItemRemovedSuccess(r),
    ));
  }

  FutureOr<void> clearCart(ClearCart event, Emitter emit) async {
    emit(CartLoading());
    final result = await clearCartUseCase(event.userId);
    emit(result.fold(
      (l) => CartError(l),
      (r) => CartClearedSuccess(r),
    ));
  }
}
