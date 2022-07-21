import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/product_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/get_product.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

class ProductRepositoryMock extends Mock implements IProductRepository {}

void main() {
  final productRepositoryMock = ProductRepositoryMock();
  final sut = GetProductUseCase(productRepositoryMock);
  setUp(() {
    registerFallbackValue(AuthCredentials());
  });

  test('should return an AuthResultModel entity', () async {
    when(() => productRepositoryMock.getProduct(any())).thenAnswer(
      (_) async => Right(ProductResultModel()),
    );
    final result = await sut('1');
    final actual = result.fold(id, id);
    expect(actual, isA<ProductResultModel>());
    verify(() => productRepositoryMock.getProduct(any())).called(1);
  });

  test('should return an exception when text is invalid', () async {
    when(() => productRepositoryMock.getProduct(''))
        .thenAnswer((_) async => Right(ProductResultModel()));
    /*
    o retorno do product repository é o Right correto mas
    está sendo passado um valor inválido para o parâmetro id
    */

    var result = await sut('');
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<InvalidIdException>());
    verifyNever(() => productRepositoryMock.getProduct(any()));
  });
}
