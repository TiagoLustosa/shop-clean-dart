import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/auth_with_email.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_state.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class AuthWithEmailMock extends Mock implements IAuthWithEmail {
  @override
  Future<Either<IAuthExceptions, Auth?>> call(
    String? email,
    String? password,
  ) {
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
  final usecase = AuthWithEmailMock();
  final authBloc = AuthBloc(usecase);

  test('Should return initial state', () {
    expect(authBloc.state, isA<AuthStart>());
  });

  test('should return state', () {
    when(usecase(any, any)).thenAnswer((realInvocation) async => Right(Auth()));
    authBloc.add(AuthWithEmailSend('email', 'password'));
    expect(
        authBloc.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthSuccess>(),
        ]));
  });
  test('should return error', () {
    when(usecase(any, any))
        .thenAnswer((realInvocation) async => Left(InvalidTextError()));
    authBloc.add(AuthWithEmailSend('email', 'password'));
    expect(
        authBloc.stream,
        emitsInOrder([
          isA<AuthLoading>(),
          isA<AuthError>(),
        ]));
  });

  //estudar para funcionar com blocTest
  blocTest<AuthBloc, AuthState>('should emit states',
      build: () => authBloc,
      act: (_) => authBloc.add(AuthWithEmailSend('a', 'a')),
      expect: () => <AuthState>[
            AuthLoading(),
            AuthSuccess(Auth()),
          ]);
  blocTest<AuthBloc, AuthState>('should emit states 2',
      build: () => authBloc,
      act: (_) => authBloc.add(AuthWithEmailSend('a', 'a')),
      expect: () => emitsInOrder([
            const AuthLoading(),
            AuthError(InvalidTextError()),
          ]));
}
