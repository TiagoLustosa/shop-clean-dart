import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/product_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/delete_product.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

class ProductRepositoryMock extends Mock implements IProductRepository {}

void main() {
  final productRepositoryMock = ProductRepositoryMock();
  final sut = DeleteProductUseCase(productRepositoryMock);
  setUp(() {
    registerFallbackValue(ProductResultModel());
  });

  test('should return true when product deleted', () async {
    when(() => productRepositoryMock.deleteProduct(any())).thenAnswer(
      (_) async => Right(true),
    );
    final result = await sut('id');
    final actual = result.fold(id, id);
    expect(actual, isA<bool>());
    expect(actual, true);
    verify(() => productRepositoryMock.deleteProduct(any())).called(1);
  });

  test('should return an error when product not deleted', () async {
    when(() => productRepositoryMock.deleteProduct(any())).thenAnswer(
      (_) async => Left(ProductDataSourceException(message: 'Error')),
    );
    var result = await sut('id');
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<ProductDataSourceException>());
  });
}
