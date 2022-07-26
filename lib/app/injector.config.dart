// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import 'injector.dart' as _i53;
import 'shop/domain/entities/auth.dart' as _i13;
import 'shop/domain/entities/auth_credentials.dart' as _i14;
import 'shop/domain/repositories/auth_repository.dart' as _i8;
import 'shop/domain/repositories/cart_repository.dart' as _i19;
import 'shop/domain/repositories/order_repository.dart' as _i25;
import 'shop/domain/repositories/product_repository.dart' as _i29;
import 'shop/domain/usecases/auth_usecases/auth_with_email.dart' as _i15;
import 'shop/domain/usecases/base_usecase/base_usecase.dart' as _i12;
import 'shop/domain/usecases/cart_usecases/add_or_update_cart_usecase.dart'
    as _i36;
import 'shop/domain/usecases/cart_usecases/contracts/add_or_update_cart_usecase_contract.dart'
    as _i35;
import 'shop/domain/usecases/cart_usecases/contracts/get_from_cart_usecase_contract.dart'
    as _i21;
import 'shop/domain/usecases/cart_usecases/contracts/remove_from_cart_usecase_contract.dart'
    as _i31;
import 'shop/domain/usecases/cart_usecases/get_from_cart_usecase.dart' as _i22;
import 'shop/domain/usecases/cart_usecases/remove_from_cart_usecase.dart'
    as _i32;
import 'shop/domain/usecases/order_usecase/contracts/create_order_usecase_contract.dart'
    as _i39;
import 'shop/domain/usecases/order_usecase/contracts/get_order_usecase_contract.dart'
    as _i43;
import 'shop/domain/usecases/order_usecase/create_order_usecase.dart' as _i40;
import 'shop/domain/usecases/order_usecase/get_orders_usecase.dart' as _i44;
import 'shop/domain/usecases/product_usecases/add_product.dart' as _i38;
import 'shop/domain/usecases/product_usecases/contracts/add_product_usecase_contract.dart'
    as _i37;
import 'shop/domain/usecases/product_usecases/contracts/delete_product_usecase_contract.dart'
    as _i41;
import 'shop/domain/usecases/product_usecases/contracts/get_product_usecase_contract.dart'
    as _i45;
import 'shop/domain/usecases/product_usecases/contracts/get_products_list_usecase_contract.dart'
    as _i47;
import 'shop/domain/usecases/product_usecases/contracts/update_product_usecase_contract.dart'
    as _i33;
import 'shop/domain/usecases/product_usecases/delete_product.dart' as _i42;
import 'shop/domain/usecases/product_usecases/get_product.dart' as _i46;
import 'shop/domain/usecases/product_usecases/get_products_list.dart' as _i48;
import 'shop/domain/usecases/product_usecases/update_product_usecase.dart'
    as _i34;
import 'shop/external/datasources/firebase_auth_datasource.dart' as _i7;
import 'shop/external/datasources/firebase_cart_datasource.dart' as _i18;
import 'shop/external/datasources/firebase_order_datasource.dart' as _i24;
import 'shop/external/datasources/firebase_product_datasource.dart' as _i28;
import 'shop/infra/datasources/auth_datasource.dart' as _i6;
import 'shop/infra/datasources/cart_datasource.dart' as _i17;
import 'shop/infra/datasources/order_datasource.dart' as _i23;
import 'shop/infra/datasources/product_datasource.dart' as _i27;
import 'shop/infra/repositories/auth_repository_implements.dart' as _i9;
import 'shop/infra/repositories/cart_repository_implements.dart' as _i20;
import 'shop/infra/repositories/order_repository_implements.dart' as _i26;
import 'shop/infra/repositories/product_repository_implements.dart' as _i30;
import 'shop/infra/rest_client/custom_dio.dart' as _i11;
import 'shop/infra/rest_client/rest_client.dart' as _i10;
import 'shop/presenter/auth/bloc/auth_bloc.dart' as _i16;
import 'shop/presenter/cart/bloc/cart_bloc.dart' as _i52;
import 'shop/presenter/order/bloc/order_bloc.dart' as _i49;
import 'shop/presenter/product/bloc/product_bloc.dart' as _i50;
import 'shop/presenter/products_list/bloc/bloc/products_list_bloc.dart' as _i51;

const String _prod = 'prod';
const String _dev = 'dev';
const String _test = 'test';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.Logger>(registerModule.loggerProd(),
      registerFor: {_prod, _dev});
  gh.singleton<_i3.Logger>(registerModule.loggerTest(), registerFor: {_test});
  await gh.singletonAsync<_i4.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true);
  gh.factory<String>(() => registerModule.baseUrl, instanceName: 'BaseUrl');
  gh.singleton<_i5.Dio>(registerModule.dio(
      get<String>(instanceName: 'BaseUrl'), get<_i3.Logger>()));
  gh.factory<_i6.IAuthDataSource>(
      () => _i7.FirebaseAuthDataSource(get<_i5.Dio>()));
  gh.factory<_i8.IAuthRepository>(
      () => _i9.AuthRepositoryImplements(get<_i6.IAuthDataSource>()));
  gh.factory<_i10.IRestClient>(
      () => _i11.CustomDio(get<_i4.SharedPreferences>(), get<_i5.Dio>()));
  gh.factory<_i12.UseCase<_i13.Auth, _i14.AuthCredentials>>(() =>
      _i15.AuthWithEmail(
          get<_i8.IAuthRepository>(), get<_i4.SharedPreferences>()));
  gh.factory<_i16.AuthBloc>(() => _i16.AuthBloc(
      usecase: get<_i12.UseCase<_i13.Auth, _i14.AuthCredentials>>()));
  gh.factory<_i17.ICartDataSource>(
      () => _i18.FirebaseCartDatasource(get<_i10.IRestClient>()));
  gh.factory<_i19.ICartRepository>(
      () => _i20.CartRepositoryImplements(get<_i17.ICartDataSource>()));
  gh.factory<_i21.IGetFromCartUseCase>(
      () => _i22.GetFromCartUseCase(get<_i19.ICartRepository>()));
  gh.factory<_i23.IOrderDataSource>(
      () => _i24.FirebaseOrderDataSource(get<_i10.IRestClient>()));
  gh.factory<_i25.IOrderRepository>(
      () => _i26.OrderRepository(get<_i23.IOrderDataSource>()));
  gh.factory<_i27.IProductDataSource>(
      () => _i28.FirebaseProductDataSource(get<_i10.IRestClient>()));
  gh.factory<_i29.IProductRepository>(
      () => _i30.ProductRepositoryImplements(get<_i27.IProductDataSource>()));
  gh.factory<_i31.IRemoveFromCartUseCase>(
      () => _i32.RemoveFromCartUseCase(get<_i19.ICartRepository>()));
  gh.factory<_i33.IUpdateProductUseCase>(
      () => _i34.UpdateProductUseCase(get<_i29.IProductRepository>()));
  gh.factory<_i35.IAddOrUpdateCartUseCase>(
      () => _i36.AddOrUpdateCartUseCase(get<_i19.ICartRepository>()));
  gh.factory<_i37.IAddProductUseCase>(
      () => _i38.AddProductUseCase(get<_i29.IProductRepository>()));
  gh.factory<_i39.ICreateOrderUseCase>(
      () => _i40.CreateOrderUseCase(get<_i25.IOrderRepository>()));
  gh.factory<_i41.IDeleteProductUseCase>(
      () => _i42.DeleteProductUseCase(get<_i29.IProductRepository>()));
  gh.factory<_i43.IGetOrderUseCase>(
      () => _i44.GetOrdersUseCase(get<_i25.IOrderRepository>()));
  gh.factory<_i45.IGetProductUseCase>(
      () => _i46.GetProductUseCase(get<_i29.IProductRepository>()));
  gh.factory<_i47.IGetProductsListUseCase>(
      () => _i48.GetProductsListUseCase(get<_i29.IProductRepository>()));
  gh.factory<_i49.OrderBloc>(() => _i49.OrderBloc(
      get<_i43.IGetOrderUseCase>(), get<_i39.ICreateOrderUseCase>()));
  gh.factory<_i50.ProductBloc>(() => _i50.ProductBloc(
      getProductUseCase: get<_i45.IGetProductUseCase>(),
      addProductUseCase: get<_i37.IAddProductUseCase>(),
      updateProductUseCase: get<_i33.IUpdateProductUseCase>(),
      deleteProductUseCase: get<_i41.IDeleteProductUseCase>()));
  gh.factory<_i51.ProductsListBloc>(() => _i51.ProductsListBloc(
      productsListUseCase: get<_i47.IGetProductsListUseCase>()));
  gh.factory<_i52.CartBloc>(() => _i52.CartBloc(
      addOrUpdateCartUseCase: get<_i35.IAddOrUpdateCartUseCase>(),
      getFromCartUseCase: get<_i21.IGetFromCartUseCase>(),
      removeFromCartUseCase: get<_i31.IRemoveFromCartUseCase>()));
  return get;
}

class _$RegisterModule extends _i53.RegisterModule {}
