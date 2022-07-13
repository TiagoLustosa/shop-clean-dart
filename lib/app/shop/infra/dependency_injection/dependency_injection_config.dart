import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_clean_arch/app/shop/external/datasources/firebase_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/repositories/auth_repository_implements.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_with_email.dart';
import '../datasources/auth_datasource.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerFactory<Dio>(() => Dio());
  getIt
      .registerFactory<IAuthDataSource>(() => FirebaseDataSource(getIt<Dio>()));
  getIt.registerFactory<IAuthRepository>(
      () => AuthRepositoryImplements(getIt<IAuthDataSource>()));
  getIt.registerFactory<IAuthWithEmail>(
      () => AuthWithEmail(getIt<IAuthRepository>()));
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<IAuthWithEmail>()));
}
