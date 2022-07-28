import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/cart_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/clear_cart_usecase.dart';

class CartRepositoryMock extends Mock implements ICartRepository {}

main() {
  final cartRepositoryMock = CartRepositoryMock();
  final sut = ClearCartUseCase(cartRepositoryMock);

  test('sould return true when clear cart ', () async {
    when(() => cartRepositoryMock.clearCart(any()))
        .thenAnswer((_) async => const Right(true));
    final result = await sut('userId');
    final actual = result.fold((id), (id));
    expect(actual, true);
    verify(() => cartRepositoryMock.clearCart(any())).called(1);
  });

  test('sould return error trying clear cart', () async {
    when(() => cartRepositoryMock.clearCart(any())).thenAnswer(
        (_) async => Left(CartDataSourceException(message: 'Error')));
    final result = await sut('userId');
    final actual = result.fold((id), (id));
    expect(actual, isA<CartDataSourceException>());
    verify(() => cartRepositoryMock.clearCart(any())).called(1);
  });
}
