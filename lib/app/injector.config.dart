// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i3;

import 'injector.dart' as _i31;
import 'shop/domain/entities/auth.dart' as _i18;
import 'shop/domain/entities/auth_credentials.dart' as _i19;
import 'shop/domain/repositories/auth_repository.dart' as _i10;
import 'shop/domain/repositories/product_repository.dart' as _i14;
import 'shop/domain/usecases/auth_usecases/auth_with_email.dart' as _i20;
import 'shop/domain/usecases/base_usecase/base_usecase.dart' as _i5;
import 'shop/domain/usecases/contracts/add_product_usecase_contract.dart'
    as _i22;
import 'shop/domain/usecases/contracts/delete_product_usecase_contract.dart'
    as _i24;
import 'shop/domain/usecases/contracts/get_product_usecase_contract.dart'
    as _i26;
import 'shop/domain/usecases/contracts/get_products_list_usecase_contract.dart'
    as _i28;
import 'shop/domain/usecases/contracts/update_product_usecase_contract.dart'
    as _i16;
import 'shop/domain/usecases/product_usecases/add_product.dart' as _i23;
import 'shop/domain/usecases/product_usecases/delete_product.dart' as _i25;
import 'shop/domain/usecases/product_usecases/get_product.dart' as _i27;
import 'shop/domain/usecases/product_usecases/get_products_list.dart' as _i29;
import 'shop/domain/usecases/product_usecases/update_product_usecase.dart'
    as _i17;
import 'shop/external/datasources/firebase_auth_datasource.dart' as _i9;
import 'shop/external/datasources/firebase_product_datasource.dart' as _i13;
import 'shop/infra/datasources/auth_datasource.dart' as _i8;
import 'shop/infra/datasources/product_datasource.dart' as _i12;
import 'shop/infra/models/product_result_model.dart' as _i6;
import 'shop/infra/repositories/auth_repository_implements.dart' as _i11;
import 'shop/infra/repositories/product_repository_implements.dart' as _i15;
import 'shop/presenter/auth/bloc/auth_bloc.dart' as _i21;
import 'shop/presenter/product/bloc/product_bloc.dart' as _i30;
import 'shop/presenter/products_list/bloc/bloc/products_list_bloc.dart' as _i4;

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
  gh.factory<_i4.ProductsListBloc>(() => _i4.ProductsListBloc(
      usecase: get<_i5.UseCase<List<_i6.ProductResultModel>, _i5.NoParams>>()));
  gh.factory<String>(() => registerModule.baseUrl, instanceName: 'BaseUrl');
  gh.singleton<_i7.Dio>(registerModule.dio(
      get<String>(instanceName: 'BaseUrl'), get<_i3.Logger>()));
  gh.factory<_i8.IAuthDataSource>(
      () => _i9.FirebaseAuthDataSource(get<_i7.Dio>()));
  gh.factory<_i10.IAuthRepository>(
      () => _i11.AuthRepositoryImplements(get<_i8.IAuthDataSource>()));
  gh.factory<_i12.IProductDataSource>(
      () => _i13.FirebaseProductDataSource(get<_i7.Dio>()));
  gh.factory<_i14.IProductRepository>(
      () => _i15.ProductRepositoryImplements(get<_i12.IProductDataSource>()));
  gh.factory<_i16.IUpdateProductUseCase>(
      () => _i17.UpdateProductUseCase(get<_i14.IProductRepository>()));
  gh.factory<_i5.UseCase<_i18.Auth, _i19.AuthCredentials>>(
      () => _i20.AuthWithEmail(get<_i10.IAuthRepository>()));
  gh.factory<_i21.AuthBloc>(() => _i21.AuthBloc(
      usecase: get<_i5.UseCase<_i18.Auth, _i19.AuthCredentials>>()));
  gh.factory<_i22.IAddProductUseCase>(
      () => _i23.AddProductUseCase(get<_i14.IProductRepository>()));
  gh.factory<_i24.IDeleteProductUseCase>(
      () => _i25.DeleteProductUseCase(get<_i14.IProductRepository>()));
  gh.factory<_i26.IGetProductUseCase>(
      () => _i27.GetProductUseCase(get<_i14.IProductRepository>()));
  gh.factory<_i28.IGetProductsListUseCase>(
      () => _i29.GetProductsListUseCase(get<_i14.IProductRepository>()));
  gh.factory<_i30.ProductBloc>(() => _i30.ProductBloc(
      getProductUseCase: get<_i26.IGetProductUseCase>(),
      addProductUseCase: get<_i22.IAddProductUseCase>(),
      updateProductUseCase: get<_i16.IUpdateProductUseCase>(),
      deleteProductUseCase: get<_i24.IDeleteProductUseCase>()));
  return get;
}

class _$RegisterModule extends _i31.RegisterModule {}
