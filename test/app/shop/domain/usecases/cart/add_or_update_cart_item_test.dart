import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/add_or_update_cart_usecase.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

class CartRepositoryMock extends Mock implements ICartRepository {}

void main() {
  final cartRepositoryMock = CartRepositoryMock();
  final sut = AddOrUpdateCartUseCase(cartRepositoryMock);
  setUp(() {
    registerFallbackValue(CartItemResultModel(
        id: '123', name: 'asdasda', price: 124, quantity: 5));
    registerFallbackValue(Cart(
        cartItemList: <CartItemResultModel>[],
        userId: '1321',
        totalItems: 2,
        totalPrice: 123));
  });

  test('should return a CartItem entity', () async {
    when(() => cartRepositoryMock.getCart(any())).thenAnswer(
      (_) async => Right(Cart(
          cartItemList: <CartItemResultModel>[],
          userId: '12321',
          totalItems: 5,
          totalPrice: 10.0)),
    );
    when(() => cartRepositoryMock.addOrUpdateCart(any(), any())).thenAnswer(
      (_) async => Right(Cart(
          userId: '1231',
          cartItemList: <CartItemResultModel>[],
          totalItems: 5,
          totalPrice: 10.0)),
    );
    final result = await sut(
        Product(
            id: '123',
            description: 'asdasdasd',
            imageUrl: 'asdasdasda',
            name: 'asdasda',
            price: 10),
        userId: 'userId');
    final actual = result.fold(id, id);
    expect(actual, isA<Cart>());
    verify(() => cartRepositoryMock.addOrUpdateCart(any(), any())).called(1);
  });

  test('should return an exception when product is invalid', () async {
    when(() => cartRepositoryMock.getCart(any())).thenAnswer(
      (_) async => Right(Cart(
          cartItemList: <CartItemResultModel>[],
          userId: '',
          totalItems: 5,
          totalPrice: 10.0)),
    );
    when(() => cartRepositoryMock.addOrUpdateCart(any(), any())).thenAnswer(
      (_) async => Left(CartDataSourceException(message: 'Error')),
    );
    var result = await sut(
        Product(
            id: '123',
            description: 'asdasdasd',
            imageUrl: 'asdasdasda',
            name: 'asdasda',
            price: 10),
        userId: 'userId');
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<CartDataSourceException>());
  });
}
