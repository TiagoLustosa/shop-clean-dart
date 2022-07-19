import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/product_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/get_product.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/get_products_list.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/bloc/product_state.dart';
import 'package:shop_clean_arch/app/shop/presenter/products_list/bloc/bloc/products_list_bloc.dart';

class ProductBlocMock extends MockBloc<GetProductsList, ProductsListState>
    implements ProductsListBloc {
  final UseCase useCase;

  ProductBlocMock(this.useCase);
}

class ProductRepositoryMock extends Mock implements IProductRepository {}

void main() {
  final productRepository = ProductRepositoryMock();
  final usecase = GetProductsListUseCase(productRepository);
  final productBloc = ProductBlocMock(usecase);

  setUp(() {
    registerFallbackValue([]);
  });

  //  when(() => authWithEmailRepositoryMock.authWithEmail(any()))
  //         .thenAnswer((_) async => Right(AuthResultModel()));
  //     return AuthBloc(usecase);

  blocTest<ProductsListBloc, ProductsListState>('should emit error state',
      build: () {
        when(() => productRepository.getAllProducts())
            .thenAnswer((_) async => Left(EmptyList()));
        return ProductsListBloc(usecase: usecase);
      },
      act: (productBloc) => productBloc.add(GetProductsList()),
      expect: () => [
            isA<ProductsListLoading>(),
            isA<ProductsListError>(),
          ]);

  blocTest<ProductsListBloc, ProductsListState>('should emit success state',
      build: () {
        when(() => productRepository.getAllProducts())
            .thenAnswer((_) async => Right(products));
        return ProductsListBloc(usecase: usecase);
      },
      act: (productBloc) => productBloc.add(GetProductsList()),
      expect: () => [
            isA<ProductsListLoading>(),
            isA<ProductsListSuccess>(),
          ]);

  blocTest<ProductsListBloc, ProductsListState>(
      'should return same list of Products',
      build: () {
        when(() => productRepository.getAllProducts())
            .thenAnswer((_) async => Right(products));
        return ProductsListBloc(usecase: usecase);
      },
      act: (productBloc) => productBloc.add(GetProductsList()),
      expect: () {
        return [
          isA<ProductsListLoading>(),
          ProductsListSuccess(products),
        ];
      });
}

List<ProductResultModel> products = [
  ProductResultModel(
    id: '1',
    name: 'Product 1',
    description: 'Product 1 description',
    price: 10,
    imageUrl: 'https://image.com',
  ),
  ProductResultModel(
    id: '2',
    name: 'Product 2',
    description: 'Product 2 description',
    price: 20,
    imageUrl: 'https://image.com',
  ),
  ProductResultModel(
    id: '3',
    name: 'Product 3',
    description: 'Product 3 description',
    price: 30,
    imageUrl: 'https://image.com',
  ),
];
