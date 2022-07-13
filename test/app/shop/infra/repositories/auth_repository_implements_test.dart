import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/auth_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/repositories/auth_repository_implements.dart';
import 'auth_repository_implements_test.mocks.dart';

@GenerateMocks([IAuthDataSource])
main() {
  final authDataSource = MockIAuthDataSource();
  final authRepository = AuthRepositoryImplements(authDataSource);

  test('should return an result auth model', () async {
    when(authDataSource.authWithEmail('a', 'a'))
        .thenAnswer((_) async => AuthResultModel());
    final result = await authRepository.authWithEmail('a', 'a');
    expect(result | null, isA<AuthResultModel>());
  });

  test('should return an DataSourceException when datasource fail', () async {
    when(authRepository.authWithEmail('a', 'a')).thenThrow(Exception());
    final result = await authRepository.authWithEmail('a', 'a');
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<AuthDataSourceException>());
  });
}
