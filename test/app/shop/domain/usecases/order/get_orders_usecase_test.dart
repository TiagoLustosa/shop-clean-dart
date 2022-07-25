import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/order_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/order_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/order_usecase/get_orders_usecase.dart';

class OrderRepositoryMock extends Mock implements IOrderRepository {}

main() {
  final orderRepositoryMock = OrderRepositoryMock();
  final sut = GetOrdersUseCase(orderRepositoryMock);
  test('should return a list of orders', () async {
    when(() => orderRepositoryMock.getOrders(any()))
        .thenAnswer((_) async => Right(<OrderItem>[]));
    final result = await sut('userId');
    final actual = result.fold(id, id);
    expect(actual, <OrderItem>[]);
    verify(() => orderRepositoryMock.getOrders(any())).called(1);
  });

  test('should return an error ', () async {
    when(() => orderRepositoryMock.getOrders(any())).thenAnswer((_) async =>
        Left(OrderDataSourceException(message: 'Error while getting orders')));
    final result = await sut('userId');
    final actual = result.fold(id, id);
    expect(actual, isA<OrderDataSourceException>());
    verify(() => orderRepositoryMock.getOrders(any())).called(1);
  });
}
