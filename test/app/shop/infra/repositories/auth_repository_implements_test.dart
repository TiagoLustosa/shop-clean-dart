import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/auth_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/repositories/auth_repository_implements.dart';

class AuthDataSourceMock extends Mock implements IAuthDataSource {}

main() {
  setUp(() {
    registerFallbackValue(AuthCredentials());
  });
  final authDataSourceMock = AuthDataSourceMock();
  final authRepository = AuthRepositoryImplements(authDataSourceMock);
  final credentials = AuthCredentials('email', 'password');
  test('should return an result auth model', () async {
    when(() => authDataSourceMock.authWithEmail(credentials))
        .thenAnswer((_) async => AuthResultModel());
    final result = await authRepository.authWithEmail(credentials);
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<AuthResultModel>());
  });

  test('should return an DataSourceMockException when datasourceMock fail',
      () async {
    when(() => authRepository.authWithEmail(any()))
        .thenAnswer((_) async => Right(AuthResultModel()));
    final result = await authRepository.authWithEmail(AuthCredentials(''));
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<AuthDataSourceException>());
  });
}
