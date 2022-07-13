import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/auth_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/auth_with_email.dart';

class AuthRepositoryMock extends Mock implements IAuthRepository {
  @override
  Future<Either<IAuthExceptions, Auth?>> authWithEmail(
      String? email, String? password) async {
    return super.noSuchMethod(
      Invocation.method(
        #authWithEmail,
        [email, password],
      ),
      returnValue: Future<Either<IAuthExceptions, Auth?>>.value(
        Right(
          Auth(),
        ),
      ),
      returnValueForMissingStub: Future<Either<IAuthExceptions, Auth?>>.value(
        Left(
          InvalidTextError(),
        ),
      ),
    );
  }
}

void main() {
  final authRepository = AuthRepositoryMock();
  final usecase = AuthWithEmail(authRepository);
  test('should return an auth entity', () async {
    when(authRepository.authWithEmail('a', 'a'))
        .thenAnswer((_) async => Right(Auth()));
    final result = await usecase('a', 'a');
    expect(result | null, isA<Auth>());
  });

  test('should return an exception when text is invalid', () async {
    when(authRepository.authWithEmail(any, any))
        .thenAnswer((_) async => Right(Auth()));
    var result = await usecase(null, null);
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase('', '');
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
