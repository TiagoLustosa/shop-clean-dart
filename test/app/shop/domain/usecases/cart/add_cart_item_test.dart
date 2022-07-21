import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/add_to_cart_usecase.dart';

class CartRepositoryMock extends Mock implements ICartRepository {}

void main() {
  final cartRepositoryMock = CartRepositoryMock();
  final sut = AddToCartUseCase(cartRepositoryMock);
  setUp(() {
    registerFallbackValue(CartItem());
    registerFallbackValue(Cart(cartItemList: <CartItem>[], userId: ''));
  });

  test('should return a CartItem entity', () async {
    when(() => cartRepositoryMock.addToCart(any(), any())).thenAnswer(
      (_) async => Right(Cart(cartItemList: <CartItem>[], userId: '')),
    );
    final result = await sut(Product());
    final actual = result.fold(id, id);
    expect(actual, isA<Cart>());
    verify(() => cartRepositoryMock.addToCart(any(), any())).called(1);
  });

  test('should return an exception when product is invalid', () async {
    when(() => cartRepositoryMock.addToCart(any(), any())).thenAnswer(
      (_) async => Left(CartDataSourceException(message: 'Error')),
    );
    var result = await sut(Product());
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<CartDataSourceException>());
  });
}
