import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/remove_from_cart_usecase.dart';

class CartRepositoryMock extends Mock implements ICartRepository {}

main() {
  final cartRepositoryMock = CartRepositoryMock();
  final sut = RemoveFromCartUseCase(cartRepositoryMock);
  test('should return true when cartItem is removed', () async {
    when(() => cartRepositoryMock.removeFromCart(any(), any())).thenAnswer(
      (_) async => Right(true),
    );
    final result = await sut('productId');
    final actual = result.fold(id, id);
    expect(actual, true);
    verify(() => cartRepositoryMock.removeFromCart(any(), any())).called(1);
  });

  test('should return an exception when cartItem is invalid', () async {
    when(() => cartRepositoryMock.removeFromCart(any(), any())).thenAnswer(
      (_) async => Left(
          CartDataSourceException(message: 'Error while removing cartItem')),
    );
    var result = await sut('productId');
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<CartDataSourceException>());
  });
}
