import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/add_or_update_cart_usecase.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/clear_cart_usecase.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/add_or_update_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/contracts/get_from_cart_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/get_from_cart_usecase.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/remove_from_cart_usecase.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_state.dart';

class CartBlocMock extends MockBloc<CartEvent, CartState> implements CartBloc {
  @override
  final IAddOrUpdateCartUseCase addOrUpdateCartUseCase;
  @override
  final IGetFromCartUseCase getFromCartUseCase;

  CartBlocMock(this.addOrUpdateCartUseCase, this.getFromCartUseCase);
}

class CartRepositoryMock extends Mock implements ICartRepository {}

void main() {
  setUp(() {
    registerFallbackValue(AuthCredentials());
  });
  final cartRepositoryMock = CartRepositoryMock();
  final addOrUpdateCartUseCase = AddOrUpdateCartUseCase(cartRepositoryMock);
  final getFromCartUseCase = GetFromCartUseCase(cartRepositoryMock);
  final removeFromCartUseCase = RemoveFromCartUseCase(cartRepositoryMock);
  final clearCartUseCase = ClearCartUseCase(cartRepositoryMock);

  setUp(() {
    registerFallbackValue(CartItemResultModel(
      id: '1',
      name: 'test',
      price: 1,
      quantity: 1,
    ));
  });
  blocTest<CartBloc, CartState>('should emit loading and success state',
      build: () {
        when(() => cartRepositoryMock.getCart(any())).thenAnswer(
          (_) async => Right(Cart(
              cartItemList: <CartItemResultModel>[],
              userId: '123',
              totalItems: 2,
              totalPrice: 123)),
        );
        when(() => cartRepositoryMock.addOrUpdateCart(any(), any())).thenAnswer(
          (_) async => Right(Cart(
              cartItemList: <CartItemResultModel>[],
              userId: '123',
              totalItems: 2,
              totalPrice: 123)),
        );
        return CartBloc(
          addOrUpdateCartUseCase: addOrUpdateCartUseCase,
          getFromCartUseCase: getFromCartUseCase,
          removeFromCartUseCase: removeFromCartUseCase,
          clearCartUseCase: clearCartUseCase,
        );
      },
      act: (cartBloc) => cartBloc.add(AddOrUpdateCart(
          ProductResultModel(
              id: '123',
              description: 'asdasda',
              imageUrl: 'asdasdasdasd.jpg',
              name: 'teste',
              price: 29),
          'userId')),
      expect: () => [
            isA<CartLoading>(),
            isA<CartSuccess>(),
          ]);

  blocTest<CartBloc, CartState>('should emit loading and error state',
      build: () {
        when(() => cartRepositoryMock.getCart(any())).thenAnswer(
          (_) async => Right(Cart(
              cartItemList: <CartItemResultModel>[],
              userId: '123',
              totalItems: 2,
              totalPrice: 123)),
        );
        when(() => cartRepositoryMock.addOrUpdateCart(any(), any())).thenAnswer(
          (_) async => Left(
              CartDataSourceException(message: 'Erro while adding to cart')),
        );
        return CartBloc(
          addOrUpdateCartUseCase: addOrUpdateCartUseCase,
          getFromCartUseCase: getFromCartUseCase,
          removeFromCartUseCase: removeFromCartUseCase,
          clearCartUseCase: clearCartUseCase,
        );
      },
      act: (cartBloc) => cartBloc.add(AddOrUpdateCart(
          ProductResultModel(
              id: '123',
              description: 'asdasda',
              imageUrl: 'asdasdasdasd.jpg',
              name: 'teste',
              price: 29),
          'userId')),
      expect: () => [
            isA<CartLoading>(),
            isA<CartError>(),
          ]);
}
