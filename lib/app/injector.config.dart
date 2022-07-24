// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i3;

import 'injector.dart' as _i39;
import 'shop/domain/entities/auth.dart' as _i22;
import 'shop/domain/entities/auth_credentials.dart' as _i23;
import 'shop/domain/repositories/auth_repository.dart' as _i7;
import 'shop/domain/repositories/cart_repository.dart' as _i11;
import 'shop/domain/repositories/product_repository.dart' as _i17;
import 'shop/domain/usecases/auth_usecases/auth_with_email.dart' as _i24;
import 'shop/domain/usecases/base_usecase/base_usecase.dart' as _i21;
import 'shop/domain/usecases/cart_usecases/add_or_update_cart_usecase.dart'
    as _i27;
import 'shop/domain/usecases/cart_usecases/contracts/add_or_update_cart_usecase_contract.dart'
    as _i26;
import 'shop/domain/usecases/cart_usecases/contracts/get_from_cart_usecase_contract.dart'
    as _i13;
import 'shop/domain/usecases/cart_usecases/get_from_cart_usecase.dart' as _i14;
import 'shop/domain/usecases/product_usecases/add_product.dart' as _i29;
import 'shop/domain/usecases/product_usecases/contracts/add_product_usecase_contract.dart'
    as _i28;
import 'shop/domain/usecases/product_usecases/contracts/delete_product_usecase_contract.dart'
    as _i30;
import 'shop/domain/usecases/product_usecases/contracts/get_product_usecase_contract.dart'
    as _i32;
import 'shop/domain/usecases/product_usecases/contracts/get_products_list_usecase_contract.dart'
    as _i34;
import 'shop/domain/usecases/product_usecases/contracts/update_product_usecase_contract.dart'
    as _i19;
import 'shop/domain/usecases/product_usecases/delete_product.dart' as _i31;
import 'shop/domain/usecases/product_usecases/get_product.dart' as _i33;
import 'shop/domain/usecases/product_usecases/get_products_list.dart' as _i35;
import 'shop/domain/usecases/product_usecases/update_product_usecase.dart'
    as _i20;
import 'shop/external/datasources/firebase_auth_datasource.dart' as _i6;
import 'shop/external/datasources/firebase_cart_datasource.dart' as _i10;
import 'shop/external/datasources/firebase_product_datasource.dart' as _i16;
import 'shop/infra/datasources/auth_datasource.dart' as _i5;
import 'shop/infra/datasources/cart_datasource.dart' as _i9;
import 'shop/infra/datasources/product_datasource.dart' as _i15;
import 'shop/infra/repositories/auth_repository_implements.dart' as _i8;
import 'shop/infra/repositories/cart_repository_implements.dart' as _i12;
import 'shop/infra/repositories/product_repository_implements.dart' as _i18;
import 'shop/presenter/auth/bloc/auth_bloc.dart' as _i25;
import 'shop/presenter/cart/bloc/cart_bloc.dart' as _i38;
import 'shop/presenter/product/bloc/product_bloc.dart' as _i36;
import 'shop/presenter/products_list/bloc/bloc/products_list_bloc.dart' as _i37;

const String _prod = 'prod';
const String _dev = 'dev';
const String _test = 'test';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.Logger>(registerModule.loggerProd(),
      registerFor: {_prod, _dev});
  gh.singleton<_i3.Logger>(registerModule.loggerTest(), registerFor: {_test});
  gh.factory<String>(() => registerModule.baseUrl, instanceName: 'BaseUrl');
  gh.singleton<_i4.Dio>(registerModule.dio(
      get<String>(instanceName: 'BaseUrl'), get<_i3.Logger>()));
  gh.factory<_i5.IAuthDataSource>(
      () => _i6.FirebaseAuthDataSource(get<_i4.Dio>()));
  gh.factory<_i7.IAuthRepository>(
      () => _i8.AuthRepositoryImplements(get<_i5.IAuthDataSource>()));
  gh.factory<_i9.ICartDataSource>(
      () => _i10.FirebaseCartDatasource(get<_i4.Dio>()));
  gh.factory<_i11.ICartRepository>(
      () => _i12.CartRepositoryImplements(get<_i9.ICartDataSource>()));
  gh.factory<_i13.IGetFromCartUseCase>(
      () => _i14.GetFromCartUseCase(get<_i11.ICartRepository>()));
  gh.factory<_i15.IProductDataSource>(
      () => _i16.FirebaseProductDataSource(get<_i4.Dio>()));
  gh.factory<_i17.IProductRepository>(
      () => _i18.ProductRepositoryImplements(get<_i15.IProductDataSource>()));
  gh.factory<_i19.IUpdateProductUseCase>(
      () => _i20.UpdateProductUseCase(get<_i17.IProductRepository>()));
  gh.factory<_i21.UseCase<_i22.Auth, _i23.AuthCredentials>>(
      () => _i24.AuthWithEmail(get<_i7.IAuthRepository>()));
  gh.factory<_i25.AuthBloc>(() => _i25.AuthBloc(
      usecase: get<_i21.UseCase<_i22.Auth, _i23.AuthCredentials>>()));
  gh.factory<_i26.IAddOrUpdateCartUseCase>(
      () => _i27.AddOrUpdateCartUseCase(get<_i11.ICartRepository>()));
  gh.factory<_i28.IAddProductUseCase>(
      () => _i29.AddProductUseCase(get<_i17.IProductRepository>()));
  gh.factory<_i30.IDeleteProductUseCase>(
      () => _i31.DeleteProductUseCase(get<_i17.IProductRepository>()));
  gh.factory<_i32.IGetProductUseCase>(
      () => _i33.GetProductUseCase(get<_i17.IProductRepository>()));
  gh.factory<_i34.IGetProductsListUseCase>(
      () => _i35.GetProductsListUseCase(get<_i17.IProductRepository>()));
  gh.factory<_i36.ProductBloc>(() => _i36.ProductBloc(
      getProductUseCase: get<_i32.IGetProductUseCase>(),
      addProductUseCase: get<_i28.IAddProductUseCase>(),
      updateProductUseCase: get<_i19.IUpdateProductUseCase>(),
      deleteProductUseCase: get<_i30.IDeleteProductUseCase>()));
  gh.factory<_i37.ProductsListBloc>(() => _i37.ProductsListBloc(
      productsListUseCase: get<_i34.IGetProductsListUseCase>()));
  gh.factory<_i38.CartBloc>(() => _i38.CartBloc(
      addOrUpdateCartUseCase: get<_i26.IAddOrUpdateCartUseCase>(),
      getFromCartUseCase: get<_i13.IGetFromCartUseCase>()));
  return get;
}

class _$RegisterModule extends _i39.RegisterModule {}
