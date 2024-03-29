import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/auth_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/user_data_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/auth_usecases/auth_with_email.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/auth/bloc/auth_state.dart';

class AuthBlocMock extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class AuthWithEmailRepositoryMock extends Mock implements IAuthRepository {}

class UserLocalDataMock extends Mock implements IUserDataRepository {}

void main() {
  setUp(() {
    registerFallbackValue(AuthCredentials());
  });
  final authWithEmailRepositoryMock = AuthWithEmailRepositoryMock();
  final userLocalDataMock = UserLocalDataMock();
  final usecase = AuthWithEmail(authWithEmailRepositoryMock, userLocalDataMock);

  setUp(() {
    registerFallbackValue(AuthCredentials());
    registerFallbackValue(Auth());
  });

  blocTest<AuthBloc, AuthState>('should emit error state',
      build: () => AuthBloc(usecase: usecase),
      act: (authBloc) => authBloc.add(AuthWithEmailSend(AuthCredentials())),
      expect: () => [
            isA<AuthLoading>(),
            isA<AuthError>(),
          ]);
  blocTest<AuthBloc, AuthState>('should emit success state ',
      build: () {
        when(() => userLocalDataMock.setUserLocalData(any()))
            .thenAnswer((_) async => Right(true));
        when(() => authWithEmailRepositoryMock.authWithEmail(any()))
            .thenAnswer((_) async => Right(AuthResultModel()));
        return AuthBloc(usecase: usecase);
      },
      act: (authBloc) =>
          authBloc.add(AuthWithEmailSend(AuthCredentials('a', 'a'))),
      expect: () => [
            isA<AuthLoading>(),
            isA<AuthSuccess>().having((authSuccess) => authSuccess.auth,
                'Return a success of AuthResultModel', isA<AuthResultModel>()),
          ]);
}
