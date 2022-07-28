import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/user_data_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/user_data_local_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/repositories/user_data_repository_implements.dart';

class UserDataDataSourceMock extends Mock implements IUserDataLocalDataSource {}

main() {
  final userDataDataSourceMock = UserDataDataSourceMock();
  final userDataRepository =
      UserDataRepositoryImplements(userDataDataSourceMock);

  test('should return an auth result model', () async {
    when(() => userDataDataSourceMock.getUserLocalData())
        .thenAnswer((_) async => AuthResultModel());

    final result = await userDataRepository.getUserLocalData();
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<Auth>());
    verify(() => userDataDataSourceMock.getUserLocalData()).called(1);
  });

  test('should return an exception', () async {
    when(() => userDataDataSourceMock.getUserLocalData()).thenThrow(
        (_) async => UserDataNotFoundException('User data not found'));

    final result = await userDataRepository.getUserLocalData();
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<UserDataNotFoundException>());
    verify(() => userDataDataSourceMock.getUserLocalData()).called(1);
  });
}
