import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/product_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/add_product.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

class ProductRepositoryMock extends Mock implements IProductRepository {}

void main() {
  final productRepositoryMock = ProductRepositoryMock();
  final sut = AddProductUseCase(productRepositoryMock);
  setUp(() {
    registerFallbackValue(ProductResultModel());
  });

  test('should return a Product entity', () async {
    when(() => productRepositoryMock.addProduct(any())).thenAnswer(
      (_) async => Right(ProductResultModel()),
    );
    final result = await sut(ProductResultModel());
    final actual = result.fold(id, id);
    expect(actual, isA<ProductResultModel>());
    verify(() => productRepositoryMock.addProduct(any())).called(1);
  });

  test('should return an exception when product is invalid', () async {
    when(() => productRepositoryMock.addProduct(any())).thenAnswer(
      (_) async => Left(ProductDataSourceException(message: 'Error')),
    );
    var result = await sut(ProductResultModel());
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<ProductDataSourceException>());
  });
}
