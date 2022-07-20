import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/external/datasources/firebase_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/repositories/auth_repository_implements.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/auth_usecases/auth_with_email.dart';
import '../../domain/usecases/product_usecases/add_product.dart';
import '../../domain/usecases/product_usecases/get_product.dart';
import '../../domain/usecases/product_usecases/get_products_list.dart';
import '../../presenter/product/bloc/product_bloc.dart';
import '../../presenter/product/bloc/product_event.dart';
import '../../presenter/products_list/bloc/bloc/products_list_bloc.dart';
import '../datasources/auth_datasource.dart';
import '../datasources/product_datasource.dart';
import '../repositories/product_repository_implements.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<Dio>(Dio());
  //Datasources
  getIt.registerSingleton<IAuthDataSource>(FirebaseDataSource(getIt<Dio>()));
  getIt.registerSingleton<IProductDataSource>(FirebaseDataSource(getIt<Dio>()));
  // getIt.registerSingleton<AuthWithEmail>(
  //     AuthWithEmail(getIt<IAuthRepository>()));
  //Repositories
  getIt.registerSingleton<IAuthRepository>(
      AuthRepositoryImplements(getIt<IAuthDataSource>()));
  getIt.registerSingleton<IProductRepository>(
      ProductRepositoryImplements(getIt<IProductDataSource>()));
  //UseCases
  getIt.registerSingleton<AuthWithEmail>(
      AuthWithEmail(getIt<IAuthRepository>()));
  getIt.registerSingleton<GetProduct>(GetProduct(getIt<IProductRepository>()));
  getIt.registerSingleton<AddProductUseCase>(
      AddProductUseCase(getIt<IProductRepository>()));
  getIt.registerSingleton<GetProductsListUseCase>(
      GetProductsListUseCase(getIt<IProductRepository>()));
  //Bloc
  getIt.registerSingleton<AuthBloc>(AuthBloc(getIt<AuthWithEmail>()));
  getIt.registerSingleton<ProductsListBloc>(
      ProductsListBloc(usecase: getIt<GetProductsListUseCase>()));
  getIt.registerSingleton<ProductBloc>(
      ProductBloc(productUseCase: getIt<AddProductUseCase>()));
}
