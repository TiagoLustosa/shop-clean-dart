import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/user_data_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/user_data_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/user_usecase/get_user_local_data_usecase.dart';

class UserDataRepositoryMock extends Mock implements IUserDataRepository {}

main() {
  final userDataRepositoryMock = UserDataRepositoryMock();
  final getUserLocalDataUseCase =
      GetUserLocaDataUseCase(userDataRepositoryMock);

  test('should return an auth entity', () async {
    when(() => userDataRepositoryMock.getUserLocalData())
        .thenAnswer((_) async => Right(Auth()));

    final result = await getUserLocalDataUseCase(NoParams());
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<Auth>());
    verify(() => userDataRepositoryMock.getUserLocalData()).called(1);
  });

  test('should return an exception', () async {
    when(() => userDataRepositoryMock.getUserLocalData()).thenAnswer(
        (_) async => Left(UserDataNotFoundException('User data not found')));

    final result = await getUserLocalDataUseCase(NoParams());
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<UserDataNotFoundException>());
    verify(() => userDataRepositoryMock.getUserLocalData()).called(1);
  });
}
