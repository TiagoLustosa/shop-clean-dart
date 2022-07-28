import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/auth_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/user_data_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/auth_usecases/auth_with_email.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {}

class UserLocalDataMock extends Mock implements IUserDataRepository {}

void main() {
  final authRepository = AuthRepositoryMock();
  final userLocalData = UserLocalDataMock();

  final sut = AuthWithEmail(authRepository, userLocalData);
  setUp(() {
    registerFallbackValue(AuthCredentials());
    registerFallbackValue(Auth());
  });

  test('should return an AuthResultModel entity', () async {
    when(() => authRepository.authWithEmail(any())).thenAnswer(
      (_) async => Right(AuthResultModel()),
    );
    when(() => userLocalData.setUserLocalData(any())).thenAnswer(
      (_) async => Right(true),
    );
    final result = await sut(AuthCredentials('email', 'password'));
    final actual = result.fold(id, id);
    expect(actual, isA<AuthResultModel>());
    verify(() => authRepository.authWithEmail(any())).called(1);
  });

  test('should return an exception when text is invalid', () async {
    when(() => authRepository.authWithEmail(any()))
        .thenAnswer((_) async => Right(AuthResultModel()));
    /*
    o retorno do auth repository é o Right correto mas
    está sendo passado um valor inválido para o parâmetro credentials
    */

    var result = await sut(AuthCredentials());
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<InvalidTextError>());
    verifyNever(() => authRepository.authWithEmail(any()));
  });
}
